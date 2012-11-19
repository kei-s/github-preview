$(function(){
  if (typeof GithubPreview === 'undefined') GithubPreview = {};

  // keep text and preview at 100% height
  function resize() {
    var height = $(window).height() - $("#header").outerHeight() - 20;
    $("#text").height(height);
    $(".panel").height(height);
  }
  resize();
  $(window).resize(_.debounce(resize,300));


  // sync scrolling of textarea and preview
  function syncScroll() {
    var textarea = {
      size: $('#text')[0].scrollHeight,
      visibleSize: $('#text').height(),
      position: $('#text').scrollTop()
    };
    var preview = {
      size: $('#preview')[0].scrollHeight,
      visibleSize: $('#preview').height(),
      position: $('#preview').scrollTop()
    }
    var ratio = textarea.position / (textarea.size - textarea.visibleSize);
    $('#preview').scrollTop((preview.size - preview.visibleSize) * ratio);
  }
  $('#text').scroll(syncScroll);


  // render markup into preview
  function render() {
    $.ajax({
      type: "POST",
      url: "/render",
      data: {
        format: $('#format').val(),
        data: $("#text").val()
      },
      success: function(data) {
        $('#preview').empty().append(data);
        syncScroll();
      }
    });
  }
  render();

  $("#format").change(render);
  $("#text").bind('input',_.debounce(render,300));


  // show / hide help
  var helpCaches = {};
  function showHelp() {
    var renderHelp = function(data) {
      $('#showhelp').addClass('on').text('Show Preview');
      $('#help').empty().append(data).show();
      $('#preview').hide();
    }
    if (helpCaches[$('#format').val()]) {
      renderHelp(helpCaches[$('#format').val()]);
    }
    else {
      $.ajax({
        type: "GET",
        url: "/help/"+$('#format').val(),
        success: function(data) {
          helpCaches[$('#format').val()] = data;
          renderHelp(data);
        }
      });
    }
  }

  function hideHelp() {
    $('#showhelp').removeClass('on').text('Show Formating Help');
    $('#help').hide();
    $('#preview').show();
  }

  $('#showhelp').click(function() {
    if ($('#showhelp').hasClass('on')) {
      hideHelp();
    }
    else {
      showHelp();
    }
  });

  // confirmation
  function setupConfirmation() {
    GithubPreview.changedForm = false;
    $(window).bind('beforeunload', function(e) {
      if (GithubPreview.changedForm) {
        return 'You have uncopied changes.';
      }
    });

    $('#text').bind('input', function() {
      GithubPreview.changedForm = true;
    }).bind('copy cut', function() {
      GithubPreview.changedForm = false;
    });
  }
  setupConfirmation();

});
