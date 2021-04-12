library canvas_core_module_text;

import 'package:canvas_sdk/models/app_module.dart';
import 'package:canvas_sdk/models/module_property.dart';
import 'package:canvas_sdk/services/application_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'enums.dart';

class CanvasCoreModuleText extends AppModule {
  static const String moduleTypeId = 'tech.yaama.canvas.core.text';
  String _id;
  String _title;
  Color _color;
  static const String _textPropertyKey = "text";
  static const String _fontPropertyKey = "font";
  static const String _colorPropertyKey = "color";
  static const String _sizePropertyKey = "size";
  Map<String, ModuleProperty> _properties;

  @override
  String get id => _id;

  @override
  String get title => _title;

  @override
  Map<String, ModuleProperty> get properties => _properties;

  CanvasCoreModuleText(IApplicationService applicationService)
      : super(applicationService) {
    this._id = Uuid().v1();
    this._title = "Text Field";
    this._properties = Map();
    _color = Colors.black; // set black as default color
    this._properties.addAll(
      {
        _textPropertyKey: ModuleProperty<String>(
            name: _textPropertyKey,
            displayName: 'Text',
            valueType: ValueType.text,
            value: 'Text',
            options: {},
            isRequired: false),
        _fontPropertyKey: ModuleProperty<int>(
            name: _fontPropertyKey,
            displayName: 'Font',
            valueType: ValueType.singleSelect,
            value: 0,
            options: Map.fromEntries(fontOptions.values
                .map((value) => MapEntry(value.toString(), value.index))),
            isRequired: true),
        _colorPropertyKey: ModuleProperty<int>(
            name: _colorPropertyKey,
            displayName: 'Color',
            valueType: ValueType.singleSelect,
            value: 0,
            options: Map.fromEntries(colorOptions.values
                .map((value) => MapEntry(value.toString(), value.index))),
            isRequired: true),
        _sizePropertyKey: ModuleProperty<double>(
            name: _sizePropertyKey,
            displayName: 'Size',
            valueType: ValueType.number,
            value: 20,
            options: {},
            isRequired: true)
      },
    );
  }

  @override
  Widget build() {
    String _text = this.properties[_textPropertyKey].value;
    String _font =
        fontOptions.values[this.properties[_fontPropertyKey].value].getFont;
    this._color =
        colorOptions.values[this.properties[_colorPropertyKey].value].getColor;
    double _size =
        double.tryParse(this.properties[_sizePropertyKey].value.toString());
    return Text(
      _text,
      style: TextStyle(
          fontFamily: _font,
          package: "canvas_core_module_text",
          color: _color,
          fontSize: _size ?? 15),
    );
  }

  @override
  Widget get control => Row(
        children: [
          Icon(Icons.text_fields),
          SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      );

  @override
  void setProperty<T>(String key, T value) {
    var property = _properties[key];
    var newProperty = ModuleProperty(
      name: property.name,
      displayName: property.displayName,
      valueType: property.valueType,
      value: value,
      options: property.options,
      isRequired: property.isRequired,
    );
    _properties[key] = newProperty;
  }

  @override
  String get typeId => moduleTypeId;

  static CanvasCoreModuleText fromJson(Map<String, dynamic> json) {
    return CanvasCoreModuleText(null)
      .._id = json['id'] as String
      .._title = json['title'] as String
      .._properties = (json['properties'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(
          k,
          e == null
              ? null
              : ModuleProperty.fromJson(
                  e as Map<String, dynamic>, (value) => value),
        ),
      );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'typeId': moduleTypeId,
      'title': this.title,
      'properties': this.properties?.map(
            (k, e) => MapEntry(
              k,
              e?.toJson(
                (value) => value,
              ),
            ),
          ),
    };
  }

  @override
  CanvasCoreModuleText copy() {
    var text = CanvasCoreModuleText(null);
    text._id = this.id;
    properties.forEach((key, property) {
      text.setProperty(key, property.value);
    });

    return text;
  }

  @override
  CanvasCoreModuleText copyWithNewPropertyValue<T>(String key, T value) {
    var modifiedText = this.copy();
    properties.forEach((k, v) {
      if (k == key) modifiedText.setProperty(k, value);
    });
    return modifiedText;
  }
}
