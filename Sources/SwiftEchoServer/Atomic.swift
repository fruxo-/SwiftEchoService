import Foundation

struct AtomicInt {

    fileprivate var lock = pthread_rwlock_t()
    fileprivate var value: Int

    init(with value: Int) {
        pthread_rwlock_init(&lock, nil)
        self.value = value
    }

    mutating func get() -> Int {
        pthread_rwlock_rdlock(&lock)
        defer {
            pthread_rwlock_unlock(&lock)
        }
        return value
    }

    mutating func increment(by increment: Int) {
        pthread_rwlock_wrlock(&lock)
        defer {
            pthread_rwlock_unlock(&lock)
        }
        self.value = self.value + increment
    }
}
