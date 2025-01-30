// keywords-trie.ts
class TrieNode {
  children: Map<string, TrieNode>;
  isEndOfWord: boolean;
  title: string;

  constructor() {
      this.children = new Map();
      this.isEndOfWord = false;
      this.title = '';
  }
}

export class KeywordsTrie {
  root: TrieNode;

  constructor() {
      this.root = new TrieNode();
  }

  insert(title: string) {
      let current = this.root;
      const lowerTitle = title.toLowerCase();

      for (const char of lowerTitle) {
          if (!current.children.has(char)) {
              current.children.set(char, new TrieNode());
          }
          current = current.children.get(char)!;
      }
      current.isEndOfWord = true;
      current.title = title;
  }

  findMatch(prefix: string): string {
      let current = this.root;
      const lowerPrefix = prefix.toLowerCase();

      if (!prefix.trim()) {
          return '';
      }

      for (const char of lowerPrefix) {
          if (!current.children.has(char)) {
              return '';
          }
          current = current.children.get(char)!;
      }

      return this.findFirstCompleteWord(current);
  }

  findFirstCompleteWord(node: TrieNode): string {
      if (node.isEndOfWord) {
          return node.title;
      }

      for (const childNode of node.children.values()) {
          const title = this.findFirstCompleteWord(childNode);
          if (title) return title;
      }

      return '';
  }

  findAllMatches(prefix: string): string[] {
      let current = this.root;
      const lowerPrefix = prefix.toLowerCase();
      const matches: string[] = [];

      if (!prefix.trim()) {
          return matches;
      }

      for (const char of lowerPrefix) {
          if (!current.children.has(char)) {
              return matches;
          }
          current = current.children.get(char)!;
      }

      this.collectWords(current, matches);
      return matches;
  }

  private collectWords(node: TrieNode, matches: string[]) {
      if (node.isEndOfWord) {
          matches.push(node.title);
      }

      for (const childNode of node.children.values()) {
          this.collectWords(childNode, matches);
      }
  }
}
