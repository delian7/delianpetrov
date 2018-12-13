
$( document ).ready(() => {   
  $('body').keyup(function(e){
    if(e.which == 27){
      $(".portfolio-modal.modal").each((index,element) => {
        $(element).modal('hide')
      });
    }
  });

  $('.resume-download-button').click(function() {
    $('#resume').modal('hide');
  });
});
