enum BiometricStatus {
    success(id: 10),
    no_hardware(id: 1),
    hardware_unavailable(id: 2),
    none_enrolled(id: 5);
    
    final int id;

    const BiometricStatus({
        required this.id
    });

    bool toBoolean() {
        return (this.id / 10) as bool;
    }

    BiometricStatus?.fromValue(int code) 
        = BiometricStatus.values.firstWhere((value) => value.code == code, 
                                        orElse: () => null);
}