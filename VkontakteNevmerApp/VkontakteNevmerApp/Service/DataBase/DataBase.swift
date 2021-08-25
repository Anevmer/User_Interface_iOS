//
//  DataBase.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 24.08.2021.
//

import Foundation

var currentUserId = 132

let allUsers = [
    UserProfile(id: 123, name: "Иван", surname: "Петров", friendIds: [132], communityIds: [225, 227, 232], avatarName: "user5", photoNames: ["photo1", "photo2"]),
    UserProfile(id: 124, name: "Петр", surname: "Синий", friendIds: [132], communityIds: [223, 224, 227], avatarName: "user7", photoNames: ["photo1"]),
    UserProfile(id: 125, name: "Сергей", surname: "Иванов", friendIds: [132], communityIds: [], avatarName: "user6", photoNames: ["photo1", "photo2", "photo3"]),
    UserProfile(id: 126, name: "Андрей", surname: "Алексеев", friendIds: [132], communityIds: [228], avatarName: "user3", photoNames: ["photo1", "photo2", "photo3", "photo1", "photo2"]),
    UserProfile(id: 127, name: "Николай", surname: "Видзе", friendIds: [], communityIds: [225, 228], avatarName: "user1", photoNames: []),
    UserProfile(id: 128, name: "Сергей", surname: "Иванов", friendIds: [], communityIds: [223, 226, 230], avatarName: "", photoNames: []),
    UserProfile(id: 129, name: "Артём", surname: "Артёмов", friendIds: [], communityIds: [226, 230, 232], avatarName: "user5", photoNames: []),
    UserProfile(id: 130, name: "Лёха", surname: "Жук", friendIds: [], communityIds: [], avatarName: "", photoNames: []),
    UserProfile(id: 131, name: "Корней", surname: "Сергеев", friendIds: [], communityIds: [229, 231], avatarName: "user4", photoNames: []),
    UserProfile(id: 132, name: "Виктор", surname: "Черный", friendIds: [123, 124, 125, 126], communityIds: [224, 229, 231], avatarName: "user2", photoNames: []),
]

let allCommunities = [
    Community(id: 223, name: "Гости нашего города", avatarName: "group2", membersId: [124, 128]),
    Community(id: 224, name: "Музыка со вкусом", avatarName: "group4", membersId: [132, 124]),
    Community(id: 225, name: "Смотрим кинчик", avatarName: "group3", membersId: [123, 127]),
    Community(id: 226, name: "Шуточки", avatarName: "group1", membersId: [128, 129]),
    Community(id: 227, name: "Мемный канал", avatarName: "group6", membersId: [123, 124]),
    Community(id: 228, name: "Отборные анектоды", avatarName: "group5", membersId: [126, 127]),
    Community(id: 229, name: "Что случилось?", avatarName: "group4", membersId: [132, 131]),
    Community(id: 230, name: "Новости", avatarName: "group3", membersId: [129, 128]),
    Community(id: 231, name: "Красивые обои на твой телефон", avatarName: "group2", membersId: [132, 131]),
    Community(id: 232, name: "Игрули", avatarName: "group1", membersId: [123, 129]),
]

