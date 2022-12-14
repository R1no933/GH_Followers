//
//  ErrorMessage.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 27.08.2022.
//

import Foundation

enum GHFError: String, Error {
    case titleForAlertView = "Что-то пошло не так.😱"
    case invalidUsername = "Имя пользователя сгенероровало неверный запрос. Проверьте правильность написания.😧"
    case unableToComplete = "Невозможно выполнить запрос, проверьте подключение к интернету.😧"
    case invalidResponce =  "Не корректный ответ от сервера, повторите попытку позже.😧"
    case invalidData = "Получены некорректные данные с сервера, повторите попытку позже.😧"
    case unableToFavorite = "Возникла ошибка при получении данных. Повторите попытку позже.🥸"
    case alreadyInFavorites = "Пользователь уже добалвен в избранное.😉"
}
