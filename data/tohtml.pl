use HTML::Entities;

open I, ">index.html";
print I "<head>\n";
print I "<title>Recipies</title>\n";
print I "</head>\n";
print I "<body>\n";
print I "<ul>\n";

while (<>) 
{
    if ($_ =~ /^=+$/)
    {
        if ($title ne "")
        {
            $title = encode_entities($title);
            print I "<li><a href=\"$filename\">$title</a></li>\n";

            print "$filename\n";
            open F, ">$filename";
            print F "<h1>$title</h1>\n";
            print F "<h2>Ingredients</h2>\n";
            print F "<ul>\n";
            foreach $ingredient (@ingredients)
            {
                $ingredient = encode_entities($ingredient);
                print F "<li>\n$ingredient</li>\n";
            }
            print F "</ul>\n";
            print F "<h2>Method</h2>";
            print F "<ul>\n";
            foreach $method (@method)
            {
                $method = encode_entities($method);
                print F "<li>\n$method</li>\n";
            }
            print F "</ul>\n";
            print F "<h2>Notes</h2>";
            foreach $note (@notes)
            {
                $note = encode_entities($note);
                print F "<p>\n$note</p>\n";
            }
            print F "</body>\n";
            close F;
        }

        @ingredients = ();
        @method = ();
        @notes = ();
        $title = "";
    }
    elsif ($title eq "")
    {
        $title = $_;
        chomp $title;
        $filename = $title;
        $filename =~ s/[\s\.&\/\,\[\]\'\%\"]+//g;
        $temp_filename = $filename;
        $temp_filename .= ".html";
        if (-e $temp_filename){
            $temp_filename = $filename;
            $temp_filename .= int(rand(100));
            $temp_filename .= ".html";
        }
        $filename = $temp_filename;
        $fIngredients = 0;
        $fMethod = 0;
        $fNotes = 0;
    }
    elsif ($_ =~ /^INGREDIENTS:/)
    {
        $fIngredients = 1;
        $fMethod = 0;
        $fNotes = 0;
    }
    elsif ($_ =~ /^METHOD:/)
    {
        $fIngredients = 0;
        $fMethod = 1;
        $fNotes = 0;
    }
    elsif ($_ =~ /^Description:/i || $_ =~ /Servings:/i || $_ =~ /Source:/i || $_ =~ /Yield:/i || $_ =~ /Notes:/i)
    {
        $fIngredients = 0;
        $fMethod = 0;
        $fNotes = 1;
        push @notes, $_;
    }
    elsif ($fIngredients && $_ ne "\n")
    {
        $_ =~ s/^- //;
        push @ingredients, $_;
    }
    elsif ($fMethod && $_ ne "\n")
    {
        push @method, $_;
    }
    elsif ($fNotes && $_ ne "\n")
    {
        push @notes, $_;
    }
}

print I "</ul>\n";
close I;
