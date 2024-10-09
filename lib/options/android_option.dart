class AndroidOption extends BaseOption {
    final String negativeButtonText;
    final String? description;
    final String? subtitle;
    
    const AndroidOption({
        required this.negativeButtonText,
        this.description,
        this.subtitle
    });
    
    @override
    String get platform => "Android";

    @override
    Map<String, dynamic> toArgument() {
        return {
            "negativeButtonText": negativeButtonText,
            "description": description,
            "subtitle": subtitle
        };
    }
}