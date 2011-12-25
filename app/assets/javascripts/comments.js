$(function() {
  $('.form-toggle-link').on('click', function(e){
    e.preventDefault();
    var link = $(this);
    if($('#comment-form-div').html() === ""){
      $.get(link.attr('href'), function(data) {
        var commentForm = $('#comment-form-div');
        $('#comment-form-div').html(data);
      });
    }else{
      $('#comment-form-div').show();
    }
    $(this).siblings('.hidden-form').first().toggle();
  });

  $('#comment-list').on('click', '.comment-form .cancel',function(e){
    e.preventDefault();
    $('#comment-form-div').hide();
  });
});
