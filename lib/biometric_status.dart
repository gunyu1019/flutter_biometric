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
        return (id / 10) as bool;
    }

    factory BiometricStatus.fromId(int id) {
        return BiometricStatus.values.firstWhere((obj) => obj.id == id);
    }
}