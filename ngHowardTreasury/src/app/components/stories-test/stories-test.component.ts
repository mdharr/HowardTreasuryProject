import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { firstValueFrom } from 'rxjs';

@Component({
  selector: 'app-stories-test',
  templateUrl: './stories-test.component.html',
  styleUrls: ['./stories-test.component.css']
})
export class StoriesTestComponent implements OnInit {

  pokemons: any[] = [];
  currentPage = 1;
  itemsPerPage = 20;
  loading: boolean = true;

  constructor(private http: HttpClient) {}

  async ngOnInit() {
    this.loadPokemons();
  }

  async loadPokemons() {
    try {
      const offset = (this.currentPage - 1) * this.itemsPerPage;
      const apiUrl = `https://pokeapi.co/api/v2/pokemon?limit=${this.itemsPerPage}&offset=${offset}`;
      const response: any = await firstValueFrom(this.http.get(apiUrl));

      if (response.results) {
        this.pokemons = response.results;
        for (const pokemon of this.pokemons) {
          const detailsUrl = pokemon.url;
          const detailsResponse: any = await firstValueFrom(this.http.get(detailsUrl));
          pokemon.sprite = detailsResponse.sprites.front_default;
          pokemon.types = detailsResponse.types;
          pokemon.abilities = detailsResponse.abilities;
        }
        this.loading = false;
        console.log('Fetched Pokémon page:', this.currentPage);
      }
    } catch (error) {
      console.error('Error loading Pokémon:', error);
    }
  }

  previousPage() {
    if (this.currentPage > 1) {
      this.currentPage--;
      this.loading = true;
      this.loadPokemons();
    }
  }

  nextPage() {
    this.currentPage++;
    this.loading = true;
    this.loadPokemons();
  }

  formatTypes(pokemon: any): string {
    return pokemon.types.map((type: any) => this.capitalizeLetter(type.type.name)).join(', ');
  }

  formatAbilities(pokemon: any): string {
    return pokemon.abilities.map((ability: any) => this.capitalizeLetter(ability.ability.name)).join(', ');
  }

  capitalizeLetter(word: string) {
    let letter: string = '';
    let restOfWord: string = '';

    if (word.length > 0) {
      letter = word[0]; // Get the first letter

      if (word.length > 1) {
        restOfWord = word.slice(1); // Get the rest of the word (from the second character onwards)
      }
    }

    return letter.toUpperCase() + restOfWord;
  }

}
