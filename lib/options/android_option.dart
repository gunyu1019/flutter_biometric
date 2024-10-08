class AndroidOption extends BaseOption {
    final String title;
    final String negativeButtonText;
    final String? description;
    final String? subtitle;
    
    const AndroidOption({
        required this.title,
        required this.negativeButtonText,
        this.description = null,
        this.subtitle = null
    });
    
    @override
    String platform get() = "Android";

    @override
    Map<String, dynamic> toArgument() {
        return {
            "title": title,
            "negativeButtonText": negativeButtonText,
            "description": description,
            "subtitle": subtitle
        };
    }
}