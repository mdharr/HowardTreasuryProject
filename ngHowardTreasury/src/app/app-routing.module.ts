import { IllustratorDetailsComponent } from './components/illustrator-details/illustrator-details.component';
import { IllustratorsComponent } from './components/illustrators/illustrators.component';
import { StopLightTestComponent } from './components/stop-light-test/stop-light-test.component';
import { StoriesTestComponent } from './components/stories-test/stories-test.component';
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
import { TestCardsComponent } from './components/test-cards/test-cards.component';
import { ExcerptLoopComponent } from './components/excerpt-loop/excerpt-loop.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
  { path: 'about', component: AboutComponent },
  { path: 'lists', component: UserListsComponent },
  { path: 'profile', component: UserProfileComponent },
  { path: 'collections', component: CollectionsComponent },
  { path: 'collections/:collectionId', component: CollectionDetailsComponent },
  { path: 'stories', component: StoriesComponent },
  { path: 'stories/:storyId', component: StoryDetailsComponent },
  { path: 'poems', component: PoemsComponent },
  { path: 'poems/:poemId', component: PoemDetailsComponent },
  { path: 'characters', component: CharactersComponent },
  { path: 'characters/:characterId', component: CharacterDetailsComponent },
  { path: 'miscellanea', component: MiscellaneaComponent },
  { path: 'miscellanea/:miscellaneaId', component: MiscellaneaDetailsComponent },
  { path: 'search-results', component: SearchResultsComponent },
  { path: 'search-results/:results', component: SearchResultsComponent },
  { path: 'posts', component: BlogPostsComponent },
  { path: 'posts/:postId/comments', component: BlogCommentsComponent },
  { path: 'posts/create', component: BlogPostCreationComponent },
  { path: 'illustrators', component: IllustratorsComponent },
  { path: 'illustrators/:illustratorId', component: IllustratorDetailsComponent },
  { path: 'conan', component: AnimatedCardComponent },
  { path: 'test', component: TestCardsComponent },
  { path: 'excerpt', component: ExcerptLoopComponent },
  // { path: 'stories-test', component: StoriesTestComponent },
  // { path: 'stop-light-test', component: StopLightTestComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
