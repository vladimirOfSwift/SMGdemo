# SMGdemo

A SwiftUI demo application showcasing post management with JSONPlaceholder API integration.

## Overview

SMGdemo is a SwiftUI application that demonstrates:
- Fetching and displaying posts from JSONPlaceholder API
- Creating new posts
- Viewing post details with comments
- Basic error handling and local state management

## Features

- **Post List**: Displays a list of posts fetched from JSONPlaceholder
- **Post Creation**: Form to create new posts (simulated via API)
- **Post Deletion**: Post is deleted temporarily 
- **Post Details**: Shows individual post content with related comments
- **Error Handling**: Presents user-friendly error messages
- **Local State Management**: Maintains UI state during async operations

## Project Structure

### Models
- `Post.swift`: Defines the Post data structure
- `Comment.swift`: Defines the Comment data structure
- `Constants.swift`: Contains application constants and URLs

### Services
- `APIService.swift`: Handles all network requests to JSONPlaceholder API

### View Models
- `PostListsViewModel.swift`: Manages state for the post list view
- `CreatePostViewModel.swift`: Handles post creation logic

### Views
- `PostListView.swift`: Main view displaying list of posts
- `PostDetailsView.swift`: Detailed view for individual posts
- `CreatePostView.swift`: Form for creating new posts

## Technical Details

### Dependencies
- SwiftUI
- Combine (for ObservableObject)
- Async/Await for network requests

### API Integration
The app uses JSONPlaceholder's free fake API:
- Base URL: `https://jsonplaceholder.typicode.com`
- Image placeholder service: `https://picsum.photos/600/200`

### Key Implementation Notes
1. **Singleton Pattern**: Used for `APIService` and `Constants` to ensure single instances
2. **MainActor**: ViewModels are marked with `@MainActor` to ensure UI updates happen on main thread
3. **Error Handling**: Comprehensive error handling with user-friendly messages
4. **Preview Providers**: All views include SwiftUI previews

## Known Limitations
1. Created posts are not actually persisted on the server (JSONPlaceholder is a mock API)
2. The app uses a hardcoded userId (1) for post creation
3. Image URLs are static placeholders (not post-specific)

## Running the Project
1. Clone the repository
2. Open the project in Xcode
3. Build and run on your preferred simulator or device

## Screenshots
(You may want to add screenshots of the main views here)

## Author
Vladimir Savic