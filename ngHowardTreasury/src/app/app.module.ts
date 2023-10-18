import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { MatButtonModule } from '@angular/material/button';
import { MatMenuModule } from '@angular/material/menu';
import { MatDialogModule } from '@angular/material/dialog';
import { MatInputModule } from '@angular/material/input';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatCheckboxModule } from '@angular/material/checkbox';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './components/home/home.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NavbarComponent } from './components/navbar/navbar.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { LoginDialogComponent } from './components/login-dialog/login-dialog.component';
import { RegisterDialogComponent } from './components/register-dialog/register-dialog.component';
import { CollectionsComponent } from './components/collections/collections.component';
import { CollectionDetailsComponent } from './components/collection-details/collection-details.component';
import { StoriesComponent } from './components/stories/stories.component';
import { StoryDetailsComponent } from './components/story-details/story-details.component';
import { PoemsComponent } from './components/poems/poems.component';
import { PoemDetailsComponent } from './components/poem-details/poem-details.component';
import { CharactersComponent } from './components/characters/characters.component';
import { CharacterDetailsComponent } from './components/character-details/character-details.component';
import { MiscellaneaComponent } from './components/miscellanea/miscellanea.component';
import { MiscellaneaDetailsComponent } from './components/miscellanea-details/miscellanea-details.component';
import { SearchComponent } from './components/search/search.component';
import { SearchResultsComponent } from './components/search-results/search-results.component';
import { AboutComponent } from './components/about/about.component';
import { UserListsComponent } from './components/user-lists/user-lists.component';
import { UserProfileComponent } from './components/user-profile/user-profile.component';
import { StoriesTestComponent } from './components/stories-test/stories-test.component';
import { AddToUserListDialogComponent } from './components/add-to-user-list-dialog/add-to-user-list-dialog.component';
import { ScrollToTopButtonComponent } from './components/scroll-to-top-button/scroll-to-top-button.component';
import { CreateUserListDialogComponent } from './components/create-user-list-dialog/create-user-list-dialog.component';
import { ToggleRedModeButtonComponent } from './components/toggle-red-mode-button/toggle-red-mode-button.component';
import { BlogPostsComponent } from './components/blog-posts/blog-posts.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    NavbarComponent,
    LoginComponent,
    LogoutComponent,
    LoginDialogComponent,
    RegisterDialogComponent,
    CollectionsComponent,
    CollectionDetailsComponent,
    StoriesComponent,
    StoryDetailsComponent,
    PoemsComponent,
    PoemDetailsComponent,
    CharactersComponent,
    CharacterDetailsComponent,
    MiscellaneaComponent,
    MiscellaneaDetailsComponent,
    SearchComponent,
    SearchResultsComponent,
    AboutComponent,
    UserListsComponent,
    UserProfileComponent,
    StoriesTestComponent,
    AddToUserListDialogComponent,
    ScrollToTopButtonComponent,
    CreateUserListDialogComponent,
    ToggleRedModeButtonComponent,
    BlogPostsComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    NgbModule,
    MatToolbarModule,
    MatSidenavModule,
    MatIconModule,
    MatListModule,
    MatButtonModule,
    BrowserAnimationsModule,
    MatSnackBarModule,
    MatMenuModule,
    MatInputModule,
    MatExpansionModule,
    MatDialogModule,
    MatProgressSpinnerModule,
    MatCheckboxModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
