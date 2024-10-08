enum BiometricStatus {
    success(id: 10),
    no_hardware(id: 1),
    hardware_unavailable(id: 2),
    none_enrolled(id: 5);
    
    final int id;

    const BiometricStatus({
        required this.id
    });
}