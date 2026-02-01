extends Node

class_name VNRoot

var vn_text_panel : TextureRect 
var vn_text_label : RichTextLabel 
var vn_fade_panel : ColorRect 
var vn_options_layout : BoxContainer 
var vn_options_template_button : Button 
var vn_name_panel: Panel 
var vn_name_label: Label 

func init() -> void:
	vn_text_panel = $Root/TextPanel
	vn_text_label = $Root/TextPanel/TextLabel
	vn_fade_panel = $Root/FadePanel
	vn_options_layout = $Root/OptionsLayout
	vn_options_template_button  = $Root/OptionsLayout/OptionTemplateButton
	vn_name_label = $Root/TextPanel/NameLabel
