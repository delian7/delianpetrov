

$(document).ready(() => {
  const iframe = document.querySelector("#resume-container");
  const iframeBody = iframe.contentDocument.body;
  let originalHeight = null;

  $( window ).resize(function() {
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
  }

  injectResume = async () => {
    const response = await fetch("https://raw.githubusercontent.com/delian7/pandoc_resume/master/output/resume.html");
    const html = await response.text();

    const iframe = document.querySelector("#resume-container");
    const iframeBody = iframe.contentDocument.body;
    iframeBody.innerHTML = html;
  }

  injectResume();
});
