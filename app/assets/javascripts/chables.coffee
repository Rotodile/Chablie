class @Chable
  @add_atwho = ->
    $('#chable_content').atwho
      at: '@'
      displayTpl:"<li class='mention-item' data-value='(${name},${picture})'>${name}${picture}</li>",
      callbacks: remoteFilter: (query, callback) ->
        if (query.length < 1)
          return false
        else
          $.getJSON '/mentions', { q: query }, (data) ->
            callback data

jQuery ->
Post.add_atwho()