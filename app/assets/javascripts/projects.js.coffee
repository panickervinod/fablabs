//= require masonry.pkgd.min.js
//= require trianglify.min.js

formatUser = (res) ->
  if res.loading
    return res
  markup = '<img alt="' + res.username + '" class="avatar tiny" src="' + res.avatar + '">' + '&nbsp;&nbsp;&nbsp;' + res.username
  markup


formatUserSelection = (res) ->
  '<img alt="' + res.username + '" class="avatar tiny" src="' + res.avatar + '">' + '&nbsp;&nbsp;&nbsp;' + res.username


formatLab = (res) ->
  if res.loading
    return res
  markup = '<img alt="' + res.name + '" class="avatar tiny" src="' + res.avatar + '">' + '&nbsp;&nbsp;&nbsp;' + res.name
  markup


formatLabSelection = (res) ->
  '<img alt="' + res.name + '" class="avatar tiny" src="' + res.avatar + '">' + '&nbsp;&nbsp;&nbsp;' + res.name


triglify = (h, w) ->
  size = Math.floor Math.random() * 99 + 1
  pattern = Trianglify(
      height: h,
      width: w,
      cell_size: size,
      x_colors: 'random'
    )
  image = 'url(' + pattern.png() + ')'

  return image


$(window).load ->
  if ($('#project-container'))
    $('#project-container').masonry itemSelector: '#project-container li'

  if $('#project-container li .project').length > 0
    $('#project-container li .project').each ->
      image = triglify(150, 350)
      $(this).children('.project-title').css('background-image', image)

  if $('.main-project')
    image = triglify(300, 1200)
    $('.main-project').css('background-image', image)

  $('#contributions_attributes').select2
    placeholder: "Select a user..",
    allowClear: true
    ajax:
      url: 'https://api.fablabs.io/v0/users'
      dataType: 'json'
      delay: 250
      data: (params) ->
        {
          username: params.term
        }
      processResults: (data) ->
        # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to
        # alter the remote JSON data
        { results: data.users }
      cache: true
    escapeMarkup: (markup) ->
      markup
    minimumInputLength: 1
    templateResult: formatUser
    templateSelection: formatUserSelection

    $('#collaborations_attributes').select2
      placeholder: "Select a lab..",
      allowClear: true
      ajax:
        url: 'https://api.fablabs.io/v0/labs'
        dataType: 'json'
        delay: 250
        data: (params) ->
          {
            name: params.term
          }
        processResults: (data) ->
          # parse the results into the format expected by Select2.
          # since we are using custom formatting functions we do not need to
          # alter the remote JSON data
          { results: data.labs }
        cache: true
      escapeMarkup: (markup) ->
        markup
      minimumInputLength: 1
      templateResult: formatLab
      templateSelection: formatLabSelection

  return