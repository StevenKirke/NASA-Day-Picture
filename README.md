#  NASA Day Pictures

## Description
#### Данное приложение является тестовой работой, для выявление навыков работы с:
##### * Многопоточностью,
##### * Паджинацией,
##### * "кешем", 
##### * "верской кода с использованием  SnapKit",

#### Включает в себя сцены:
##### * "Все фото",
##### * "Поиск".

## Getting started
#####

## Usage
####

## Architecture
#### В данном проекте используется архитектура Clean Architecture.

## Structure

``` bash
└── NASA Day Picture
    ├── README.md
    └── NASA Day Picture
        ├── Enums
        │   └── URLS.swift
        ├── Assets
        │   └── Colors
        │       ├── CustomColors.swift
        │       └── StyleColors.swift
        ├── Extensions
        │   └── ExtensionUIColor.swift
        ├── Managers
        │       ├── DecodeJSONManager.swift
        │       └── NetworkManager.swift
        ├── Services
        ├── Coordinators
        │   │── Common
        │   │   └── ICoordinator.swift
        │   ├── AppCoordinator.swift
        │   ├── MainCoordinator.swift
        │   ├── MainPicturesCoordinator.swift
        │   ├── MainSearchCoordinator.swift
        ├── Flows
        │   ├── IConfigurator.swift
        │   ├── MainFlow
        │   │   ├── TabBarController.swift
        │   │   └── TabBarPage.swift
        │   ├── PictureFlow
        │   │   └── MainPicturesScene
        │   │       ├── MainPicturesAssembler.swift
        │   │       ├── MainPicturesViewController.swift
        │   │       ├── MainPicturesIterator.swift
        │   │       ├── MainPicturesPresenter.swift
        │   │       ├── MainPicturesViewModel.swift
        │   │       └── Worker
   	    │   │           ├── MainPicturesWorker.swift
        │   │           └── CollectionDTO.swift
        │   └── SearchFlow
        │       └── MainSearchScene
        │           ├── MainSearchAssembler.swift
        │           ├── MainSearchViewController.swift
        │           ├── MainSearchIterator.swift
        │           ├── MainSearchPresenter.swift
        │           ├── MainSearchModel.swift
        │           └── MainSearchWorker.swift
        ├── Application
        │   ├── AppDelegate.swift
        │   └── SceneDelegate.swift
        └── Resources
            ├── swiftlint.yml
            ├── LaunchScreen.storyboard
            ├── Assets.xcassets
            └── Info.plist
```

## Running the tests

## Dependencies
####

## Workflow
#### XCode version: 15.2 
#### iOS version: 14.2

## Design
#### Дизайн для приложения выполнен по картинке.

## Task boards
#### Для координации используется Kaiten.

## API
#### В приложении используются API:
##### * [NASA API ](https://api.nasa.gov/) 
