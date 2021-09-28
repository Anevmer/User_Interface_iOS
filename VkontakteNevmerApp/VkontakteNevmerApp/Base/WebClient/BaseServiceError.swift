//
//  BaseServiceError.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 28.09.2021.
//

import Foundation

enum BaseServiceError: Error {
    case tokenExpired
    case connectionError
    case userNotFound
    case custom(String)
}

extension BaseServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .tokenExpired:
            return "Время жизни токена истекло"
        case .connectionError:
            return "Ошибка соединения с сервером. Попробуйте еще раз."
        case .userNotFound:
            return "Пользователь не найден"
        case .custom(let message):
            return message
        }
    }
}
