import { ImageGalleryComponent } from './components/image-gallery/image-gallery.component';
import { BlogPostEditComponent } from './components/blog-post-edit/blog-post-edit.component';
import { IllustratorDetailsComponent } from './components/illustrator-details/illustrator-details.component';
import { IllustratorsComponent } from './components/illustrators/illustrators.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AboutComponent } from './components/about/about.component';
import { BlogPostsComponent } from './components/blog-posts/blog-posts.component';
import { CharacterDetailsComponent } from './components/character-details/character-details.component';
import { CharactersComponent } from './components/characters/characters.component';
import { CollectionDetailsComponent } from './components/collection-details/collection-details.component';
import { CollectionsComponent } from './components/collections/collections.component';
import { HomeComponent } from './components/home/home.component';
import { MiscellaneaDetailsComponent } from './components/miscellanea-details/miscellanea-details.component';
import { MiscellaneaComponent } from './components/miscellanea/miscellanea.component';
import { PoemDetailsComponent } from './components/poem-details/poem-details.component';
import { PoemsComponent } from './components/poems/poems.component';
import { SearchResultsComponent } from './components/search-results/search-results.component';
import { StoriesComponent } from './components/stories/stories.component';
import { StoryDetailsComponent } from './components/story-details/story-details.component';
import { UserListsComponent } from './components/user-lists/user-lists.component';
import { UserProfileComponent } from './components/user-profile/user-profile.component';
import { BlogCommentsComponent } from './components/blog-comments/blog-comments.component';
import { BlogPostCreationComponent } from './components/blog-post-creation/blog-post-creation.component';
import { AnimatedCardComponent } from './components/animated-card/animated-card.component';
import { VerificationComponent } from './components/verification/verification.component';
import { ChatComponent } from './components/chat/chat.component';
import { WeirdTalesComponent } from './components/weird-tales/weird-tales.component';
import { WeirdTalesDetailsComponent } from './components/weird-tales-details/weird-tales-details.component';
import { authGuard } from './guards/auth.guard';
import { AdventureComponent } from './components/adventure/adventure.component';
import { RxjsPracticeComponent } from './components/rxjs-practice/rxjs-practice.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent, data: { animation: 'HomePage' } },
  { path: 'verify', component: VerificationComponent, data: { animation: 'VerifyPage' } },
  { path: 'about', component: AboutComponent, data: { animation: 'AboutPage' } },
  { path: 'lists', component: UserListsComponent, canActivate: [authGuard], data: { animation: 'ListsPage' } },
  { path: 'profile', component: UserProfileComponent, canActivate: [authGuard], data: { animation: 'ProfilePage' } },
  { path: 'collections', component: CollectionsComponent, data: { animation: 'CollectionsPage' } },
  { path: 'collections/:collectionId', component: CollectionDetailsComponent, data: { animation: 'CollectionDetailsPage' } },
  { path: 'stories', component: StoriesComponent, data: { animation: 'StoriesPage' } },
  { path: 'stories/:storyId', component: StoryDetailsComponent, data: { animation: 'StoryDetailsPage' } },
  { path: 'poems', component: PoemsComponent, data: { animation: 'PoemsPage' } },
  { path: 'poems/:poemId', component: PoemDetailsComponent, data: { animation: 'PoemDetailsPage' } },
  { path: 'characters', component: CharactersComponent, data: { animation: 'CharactersPage' } },
  { path: 'characters/:characterId', component: CharacterDetailsComponent, data: { animation: 'CharacterDetailsPage' } },
  { path: 'miscellanea', component: MiscellaneaComponent, data: { animation: 'MiscellaneaPage' } },
  { path: 'miscellanea/:miscellaneaId', component: MiscellaneaDetailsComponent, data: { animation: 'MiscellaneaDetailsPage' } },
  { path: 'search-results', component: SearchResultsComponent, data: { animation: 'SearchResultsPage' } },
  { path: 'search-results/:results', component: SearchResultsComponent, data: { animation: 'SearchResultsDetailsPage' } },
  { path: 'posts', component: BlogPostsComponent, data: { animation: 'PostsPage' } },
  { path: 'posts/:postId/comments', component: BlogCommentsComponent, data: { animation: 'CommentsPage' } },
  { path: 'posts/create', component: BlogPostCreationComponent, canActivate: [authGuard], data: { animation: 'CreatePostPage' } },
  { path: 'illustrators', component: IllustratorsComponent, data: { animation: 'IllustratorsPage' } },
  { path: 'illustrators/:illustratorId', component: IllustratorDetailsComponent, data: { animation: 'IllustratorDetailsPage' } },
  { path: 'weird-tales', component: WeirdTalesComponent, data: { animation: 'WeirdTalesPage' } },
  { path: 'weird-tales/:weirdTalesId', component: WeirdTalesDetailsComponent, data: { animation: 'WeirdTalesDetailsPage' } },
  { path: 'conan', component: AnimatedCardComponent, data: { animation: 'ConanPage' } },
  { path: 'posts/:postId/edit', component: BlogPostEditComponent, data: { animation: 'EditPostPage' } },
  { path: 'chat', component: ChatComponent, canActivate: [authGuard], data: { animation: 'ChatPage' } },
  { path: 'gallery', component: ImageGalleryComponent, data: { animation: 'ImageGalleryPage' } },
  { path: 'adventure', component: AdventureComponent },
  { path: 'rxjs', component: RxjsPracticeComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
