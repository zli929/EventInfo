CKEDITOR.editorConfig = (config) ->
  config.toolbar_Pure = [
    { name: 'clipboard',   items: [ 'Cut','Copy','Paste','PasteText','-','Undo','Redo' ] },
    { name: 'editing',     items: [ 'Find','Replace','-','SelectAll','-','SpellChecker'] },
    { name: 'tools',       items: [ 'Maximize', 'ShowBlocks','-','About' ] }
    { name: 'links',       items: [ 'Link','Unlink'] },
    '/',
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
    { name: 'paragraph',   items: [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
    '/',
    { name: 'styles',      items: [ 'Styles','Format','Font','FontSize' ] },
    { name: 'colors',      items: [ 'TextColor','BGColor' ] },
  ]
  config.toolbar = 'Pure'
  true