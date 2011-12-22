$(function(){
  $('.search-button').on('click', function(e){
    e.preventDefault();
    $(this).parents('.search-form').submit();
  });
});

$(function(){
  $('#more-recipes-link').on('ajax:success', function(xhr, data){
    $('#random-recipe-list').html(data)
  })
})
