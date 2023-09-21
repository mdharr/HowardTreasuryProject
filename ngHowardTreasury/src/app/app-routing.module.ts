import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CharacterDetailsComponent } from './components/character-details/character-details.component';
import { CharactersComponent } from './components/characters/characters.component';
import { CollectionDetailsComponent } from './components/collection-details/collection-details.component';
import { CollectionsComponent } from './components/collections/collections.component';
import { HomeComponent } from './components/home/home.component';
import { PoemDetailsComponent } from './components/poem-details/poem-details.component';
import { PoemsComponent } from './components/poems/poems.component';
import { StoriesComponent } from './components/stories/stories.component';
import { StoryDetailsComponent } from './components/story-details/story-details.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
  { path: 'collections', component: CollectionsComponent },
  { path: 'collections/:collectionId', component: CollectionDetailsComponent },
  { path: 'stories', component: StoriesComponent },
  { path: 'stories/:storyId', component: StoryDetailsComponent },
  { path: 'poems', component: PoemsComponent },
  { path: 'poems/:poemId', component: PoemDetailsComponent },
  { path: 'characters', component: CharactersComponent },
  { path: 'characters/:characterId', component: CharacterDetailsComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
