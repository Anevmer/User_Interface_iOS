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
    case custom(Int)
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
        case .custom(let code):
            switch code {
            case 4:
               return "Неверная подпись."
            case 5:
                return "Авторизация пользователя не удалась."
            case 7:
                return "Нет прав для выполнения этого действия."
            case 10:
                return "Произошла внутренняя ошибка сервера."
            case 15:
                return "Доступ запрещён."
            case 18:
                return "Страница удалена или заблокирована."
            case 30:
                return "Профиль является приватным "
            case 203:
                return "Доступ к группе запрещён."
            case 300:
                return "Альбом переполнен."
            default:
                return "Произошла неизвестная ошибка. "
            }
        }
    }
}
