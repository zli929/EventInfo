!function(){CKEDITOR.dialog.add("templates",function(e){function t(e,t){var l=CKEDITOR.dom.element.createFromHtml('<a href="javascript:void(0)" tabIndex="-1" role="option" ><div class="cke_tpl_item"></div></a>'),s='<table style="width:350px;" class="cke_tpl_preview" role="presentation"><tr>';return e.image&&t&&(s+='<td class="cke_tpl_preview_img"><img src="'+CKEDITOR.getUrl(t+e.image)+'"'+(CKEDITOR.env.ie6Compat?' onload="this.width=this.width"':"")+' alt="" title=""></td>'),s+='<td style="white-space:normal;"><span class="cke_tpl_title">'+e.title+"</span><br/>",e.description&&(s+="<span>"+e.description+"</span>"),l.getFirst().setHtml(s+"</td></tr></table>"),l.on("click",function(){a(e.html)}),l}function a(t){var a=CKEDITOR.dialog.getCurrent();a.getValueOf("selectTpl","chkInsertOpt")?(e.fire("saveSnapshot"),e.setData(t,function(){a.hide();var t=e.createRange();t.moveToElementEditStart(e.editable()),t.select(),setTimeout(function(){e.fire("saveSnapshot")},0)})):(e.insertHtml(t),a.hide())}function l(e){var t=e.data.getTarget(),a=i.equals(t);if(a||i.contains(t)){var l,s=e.data.getKeystroke(),n=i.getElementsByTag("a");if(n){if(a)l=n.getItem(0);else switch(s){case 40:l=t.getNext();break;case 38:l=t.getPrevious();break;case 13:case 32:t.fire("click")}l&&(l.focus(),e.data.preventDefault())}}}var s=CKEDITOR.plugins.get("templates");CKEDITOR.document.appendStyleSheet(CKEDITOR.getUrl(s.path+"dialogs/templates.css"));var i,s="cke_tpl_list_label_"+CKEDITOR.tools.getNextNumber(),n=e.lang.templates,o=e.config;return{title:e.lang.templates.title,minWidth:CKEDITOR.env.ie?440:400,minHeight:340,contents:[{id:"selectTpl",label:n.title,elements:[{type:"vbox",padding:5,children:[{id:"selectTplText",type:"html",html:"<span>"+n.selectPromptMsg+"</span>"},{id:"templatesList",type:"html",focus:!0,html:'<div class="cke_tpl_list" tabIndex="-1" role="listbox" aria-labelledby="'+s+'"><div class="cke_tpl_loading"><span></span></div></div><span class="cke_voice_label" id="'+s+'">'+n.options+"</span>"},{id:"chkInsertOpt",type:"checkbox",label:n.insertOption,"default":o.templates_replaceContent}]}]}],buttons:[CKEDITOR.dialog.cancelButton],onShow:function(){var e=this.getContentElement("selectTpl","templatesList");i=e.getElement(),CKEDITOR.loadTemplates(o.templates_files,function(){var a=(o.templates||"default").split(",");if(a.length){var l=i;l.setHtml("");for(var s=0,p=a.length;p>s;s++)for(var c=CKEDITOR.getTemplates(a[s]),r=c.imagesPath,c=c.templates,d=c.length,m=0;d>m;m++){var g=t(c[m],r);g.setAttribute("aria-posinset",m+1),g.setAttribute("aria-setsize",d),l.append(g)}e.focus()}else i.setHtml('<div class="cke_tpl_empty"><span>'+n.emptyListMsg+"</span></div>")}),this._.element.on("keydown",l)},onHide:function(){this._.element.removeListener("keydown",l)}}})}();