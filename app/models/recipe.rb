class Recipe < ActiveRecord::Base

  def self.import_from_html
    doc = open(File.join(Rails.root, 'app', 'views', 'recipes', 'recipes', 'BraisedThaiChickenLegsontheGrill.html')) { |f| Hpricot(f) }
    p "name: #{(doc/"h1").inner_html}"

    (doc/"h2").each do |h2|
      case h2.inner_html
        when 'Ingredients'
          p "Ingredients: "
          ul =  h2.next.next #an extra next to get around
          (h2.next.next/"li").each do |ingredient|
            p ingredient.inner_html.gsub!("\n", '')
          end
        when 'Method'
          p 'Methods: '
          ul = h2.next
          (h2.next/"li").each do |step|
            p step.inner_html.gsub!("\n", '')
          end
        when 'Notes'
          p 'Notes:'
          p_tag = h2.next

          while (p_tag)
            if p_tag.name == "p"
              p p_tag.inner_html.gsub!("\n", '')
            end
            p_tag = p_tag.next
          end
      end
    end

    true
  end

end
