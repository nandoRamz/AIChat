//
//  MockUserService.swift
//  AIChat
//
//  Created by Nando on 2/5/25.
//

import Foundation

struct MockUserService: UserService {
    func deleteUser(with userId: String) async throws {
        
    }
    
    func saveUser(_ user: UserModel) async throws {
        
    }
    
    func addStream(to userId: String) -> AsyncThrowingStream<UserModel?, Error> {
        return AsyncThrowingStream { continuation in
            continuation.yield(UserModel.sample)
        }
    }
}
