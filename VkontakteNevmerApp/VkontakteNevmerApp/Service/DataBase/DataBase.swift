//
//  DataBase.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 24.08.2021.
//

import Foundation

var currentUserId = 132

private var allUsers = [
    UserProfile(id: 123, name: "Иван", surname: "Петров", friendIds: [132, 130], communityIds: [225, 227, 232], avatarName: "user5", photoNames: ["photo1", "photo2"]),
    UserProfile(id: 124, name: "Петр", surname: "Синий", friendIds: [132, 130], communityIds: [223, 224, 227], avatarName: "user7", photoNames: ["photo1"]),
    UserProfile(id: 125, name: "Сергей", surname: "Иванов", friendIds: [132, 130], communityIds: [], avatarName: "user6", photoNames: ["photo1", "photo2", "photo3"]),
    UserProfile(id: 126, name: "Андрей", surname: "Сергеев", friendIds: [132, 130], communityIds: [228], avatarName: "user3", photoNames: ["photo1", "photo2", "photo3", "photo1", "photo2"]),
    UserProfile(id: 127, name: "Николай", surname: "Видзе", friendIds: [], communityIds: [225, 228], avatarName: "user1", photoNames: ["photo1", "photo1", "photo3", "photo2", "photo2"]),
    UserProfile(id: 128, name: "Сергей", surname: "Иванов", friendIds: [], communityIds: [223, 226, 230], avatarName: "", photoNames: ["photo1", "photo2", "photo3", "photo1", "photo2", "photo1", "photo3", "photo1", "photo1", "photo2"]),
    UserProfile(id: 129, name: "Артём", surname: "Артёмов", friendIds: [], communityIds: [226, 230, 232], avatarName: "user5", photoNames: ["photo3", "photo1", "photo2",]),
    UserProfile(id: 130, name: "Лёха", surname: "Жук", friendIds: [123, 124, 125, 126], communityIds: [], avatarName: "", photoNames: []),
    UserProfile(id: 131, name: "Корней", surname: "Сергеев", friendIds: [], communityIds: [229, 231], avatarName: "user4", photoNames: []),
    UserProfile(id: 132, name: "Виктор", surname: "Черный", friendIds: [123, 124, 125, 126], communityIds: [224, 229, 231], avatarName: "user2", photoNames: []),
    UserProfile(id: 133, name: "Сергей", surname: "Черненко", friendIds: [], communityIds: [], avatarName: "user2", photoNames: [])
    
]

private var allCommunities = [
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

private var allNews = [
    NewsModel(title: "Кот погладил сам себя!", description: "Никаких особенностей, просто взял и погладился о рядом стоящую стенку, ведь хозяева у него вечно занятые и на кота времени нет, вот и приходится бедняге самому о себе беспокоиться", imageUrlString: "", authorUserId: nil, authorCommunityId: 226),
    NewsModel(title: "Новый кинчик", description: "Смотрим, оставляем комменты", imageUrlString: "photo1", authorUserId: nil, authorCommunityId: 225)

]

func getMyProfile() -> UserProfile? {
    guard let currentUserProfile = allUsers.first(where: { $0.id == currentUserId}) else { return nil }
    
    return currentUserProfile
}

func getProfileWithId(userId: Int) -> UserProfile? {
    guard let currentUserProfile = allUsers.first(where: { $0.id == userId}) else { return nil }
    
    return currentUserProfile
}

func getMyFriends() -> [UserProfile] {
    return allUsers.filter({$0.friendsId.contains(currentUserId)})
}

func getOtherUsers() -> [UserProfile] {
    return allUsers.filter({!$0.friendsId.contains(currentUserId) || $0.id != currentUserId})
}

func getCommunityWithId(communityId: Int) -> Community? {
    guard let community = allCommunities.first(where: { $0.id == communityId}) else { return nil }
    
    return community
}

func getMyCommunities() -> [Community] {
    return allCommunities.filter({$0.communityMembersId.contains(currentUserId)})
}

func getOthersCommunities() -> [Community] {
    return allCommunities.filter({!$0.communityMembersId.contains(currentUserId)})
}

func getAllNews() -> [NewsModel] {
    return allNews
}

func addedCommunityToMyProfile(withCommunityId communityId: Int) -> Bool {
    guard let profile = getMyProfile(),
          let community = getCommunityWithId(communityId: communityId),
          let userIndex = allUsers.firstIndex(where: {$0.id == profile.id}),
          let communityIndex = allCommunities.firstIndex(where: {$0.id == communityId})
          else {
        return false
    }
    profile.communitiesId.append(communityId)
    community.communityMembersId.append(profile.id)
    
    allUsers[userIndex] = profile
    allCommunities[communityIndex] = community
    return true
}

func removeCommunityFromMyProfile(withCommunityId communityId: Int) -> Bool {
    guard let profile = getMyProfile(),
          let community = getCommunityWithId(communityId: communityId),
          let userIndex = allUsers.firstIndex(where: {$0.id == profile.id}),
          let communityIndex = allCommunities.firstIndex(where: {$0.id == communityId}),
          let profileIdFromCommIndex = community.communityMembersId.firstIndex(where: {$0 == profile.id}),
          let communityIdFromUserIndex = profile.communitiesId.firstIndex(where: {$0 == communityId})
          else {
        return false
    }

    profile.communitiesId.remove(at: communityIdFromUserIndex)
    community.communityMembersId.remove(at: profileIdFromCommIndex)
    
    allUsers[userIndex] = profile
    allCommunities[communityIndex] = community
    return true
}

func loginUser(withLogin login: String, andPass password: String) -> Int? {
    if login == "Admin", password == "Admin" {
        return 132
    }
    
    if login == "Admin1", password == "Admin1" {
        return 131
    }
    
    if login == "Admin2", password == "Admin2" {
        return 130
    }
    
    if login == "Admin3", password == "Admin3" {
        return 129
    }
    
    if login == "Admin4", password == "Admin4" {
        return 128
    }
    
    if login == "Admin5", password == "Admin5" {
        return 127
    }
    
    if login == "Admin6", password == "Admin6" {
        return 126
    }
    
    if login == "Admin7", password == "Admin7" {
        return 125
    }
    
    if login == "Admin8", password == "Admin8" {
        return 124
    }
    
    if login == "Admin9", password == "Admin9" {
        return 123
    }
    
    return nil
}

