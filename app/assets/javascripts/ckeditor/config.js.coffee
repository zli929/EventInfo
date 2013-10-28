CKEDITOR.editorConfig = (config) ->
  config.toolbar_Pure = [
    { name: 'clipboard',   items: [ 'Cut','Copy','Paste','PasteText','-','Undo','Redo' ] },
    { name: 'tools',       items: [ 'Maximize', 'ShowBlocks','-','About' ] }
    '/',
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
    { name: 'paragraph',   items: [ 'JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
    '/',
    { name: 'styles',      items: [ 'Styles','Format','Font','FontSize' ] },
    { name: 'colors',      items: [ 'TextColor','BGColor' ] },
  ]
  config.toolbar = 'Pure'
  true