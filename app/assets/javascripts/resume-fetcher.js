

$(document).ready(() => {
  const iframe = document.querySelector("#resume-container");
  const iframeBody = iframe.contentDocument.body;
  let originalHeight = null;

  $(window).resize(function() {
    if($("#resume-modal").hasClass("in")) {
      resizeResume();
    }
  });

  $("#resume-modal").on('show.bs.modal', () => {
    setTimeout(() => {
      originalHeight = iframeBody.scrollHeight;
      resizeResume();
    }, 250);
  });


  resizeResume = () => {
    $("#resume-container").css({height: `${originalHeight}px`});
    let offsetHeight = iframeBody.scrollHeight;
    $("#resume-container").css({height: `${offsetHeight+5}px`});
    $('#resume-container').contents().find("div").css('padding', '10pt').css('max-width', '1000pt');
  }

  injectResume = async () => {
    const response = await fetch("https://docs.google.com/document/d/e/2PACX-1vQvLYQdg5c-a0moi7KaEU_7XdHL0PhS21-MojgPvssJ0tfkhOjrKgNIkC5ADbV5U85zKUI4WKQxblG-/pub?embedded=true");
    const html = await response.text();

    const iframe = document.querySelector("#resume-container");
    const iframeBody = iframe.contentDocument.body;
    iframeBody.innerHTML = html;

    if (showResume) {
      $("#resume-modal").modal("show");
    }
  }

  injectResume();
  resizeResume();
});
