package com.skilldistillery.howardtreasury.dtos;

import java.time.LocalDateTime;
import java.util.List;

import com.skilldistillery.howardtreasury.entities.CollectionImage;
import com.skilldistillery.howardtreasury.entities.Illustrator;
import com.skilldistillery.howardtreasury.entities.Miscellanea;
import com.skilldistillery.howardtreasury.entities.Person;
import com.skilldistillery.howardtreasury.entities.Poem;
import com.skilldistillery.howardtreasury.entities.Series;

public class CollectionWithStoriesDTO {

    private int id;
    private String title;
    private LocalDateTime publishedAt;
    private Integer pageCount;
    private String description;
    private Series series;
    private List<StoryWithPageNumberDTO> stories;
    private List<Poem> poems;
    private List<Person> persons;
    private List<Miscellanea> miscellaneas;
    private List<CollectionImage> collectionImages;
    private List<Illustrator> illustrators;
    
    public CollectionWithStoriesDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CollectionWithStoriesDTO(int id, String title, LocalDateTime publishedAt, Integer pageCount,
			String description, Series series, List<StoryWithPageNumberDTO> stories, List<Poem> poems,
			List<Person> persons, List<Miscellanea> miscellaneas, List<CollectionImage> collectionImages,
			List<Illustrator> illustrators) {
		super();
		this.id = id;
		this.title = title;
		this.publishedAt = publishedAt;
		this.pageCount = pageCount;
		this.description = description;
		this.series = series;
		this.stories = stories;
		this.poems = poems;
		this.persons = persons;
		this.miscellaneas = miscellaneas;
		this.collectionImages = collectionImages;
		this.illustrators = illustrators;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public LocalDateTime getPublishedAt() {
		return publishedAt;
	}

	public void setPublishedAt(LocalDateTime publishedAt) {
		this.publishedAt = publishedAt;
	}

	public Integer getPageCount() {
		return pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Series getSeries() {
		return series;
	}

	public void setSeries(Series series) {
		this.series = series;
	}

	public List<StoryWithPageNumberDTO> getStories() {
		return stories;
	}

	public void setStories(List<StoryWithPageNumberDTO> stories) {
		this.stories = stories;
	}

	public List<Poem> getPoems() {
		return poems;
	}

	public void setPoems(List<Poem> poems) {
		this.poems = poems;
	}

	public List<Person> getPersons() {
		return persons;
	}

	public void setPersons(List<Person> persons) {
		this.persons = persons;
	}

	public List<Miscellanea> getMiscellaneas() {
		return miscellaneas;
	}

	public void setMiscellaneas(List<Miscellanea> miscellaneas) {
		this.miscellaneas = miscellaneas;
	}

	public List<CollectionImage> getCollectionImages() {
		return collectionImages;
	}

	public void setCollectionImages(List<CollectionImage> collectionImages) {
		this.collectionImages = collectionImages;
	}

	public List<Illustrator> getIllustrators() {
		return illustrators;
	}

	public void setIllustrators(List<Illustrator> illustrators) {
		this.illustrators = illustrators;
	}

	public static class StoryWithPageNumberDTO {
        private int id;
        private String title;
        private String textUrl;
        private LocalDateTime firstPublished;
        private String alternateTitle;
        private Boolean isCopyrighted;
        private LocalDateTime copyrightExpiresAt;
        private String excerpt;
        private String description;
        private Integer pageNumber;
		public StoryWithPageNumberDTO() {
			super();
			// TODO Auto-generated constructor stub
		}
		public StoryWithPageNumberDTO(int id,  String title, String textUrl,
				LocalDateTime firstPublished, String alternateTitle, Boolean isCopyrighted,
				LocalDateTime copyrightExpiresAt, String excerpt, String description, Integer pageNumber) {
			super();
			this.id = id;
			this.title = title;
			this.textUrl = textUrl;
			this.firstPublished = firstPublished;
			this.alternateTitle = alternateTitle;
			this.isCopyrighted = isCopyrighted;
			this.copyrightExpiresAt = copyrightExpiresAt;
			this.excerpt = excerpt;
			this.description = description;
			this.pageNumber = pageNumber;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getTextUrl() {
			return textUrl;
		}
		public void setTextUrl(String textUrl) {
			this.textUrl = textUrl;
		}
		public LocalDateTime getFirstPublished() {
			return firstPublished;
		}
		public void setFirstPublished(LocalDateTime firstPublished) {
			this.firstPublished = firstPublished;
		}
		public String getAlternateTitle() {
			return alternateTitle;
		}
		public void setAlternateTitle(String alternateTitle) {
			this.alternateTitle = alternateTitle;
		}
		public Boolean getIsCopyrighted() {
			return isCopyrighted;
		}
		public void setIsCopyrighted(Boolean isCopyrighted) {
			this.isCopyrighted = isCopyrighted;
		}
		public LocalDateTime getCopyrightExpiresAt() {
			return copyrightExpiresAt;
		}
		public void setCopyrightExpiresAt(LocalDateTime copyrightExpiresAt) {
			this.copyrightExpiresAt = copyrightExpiresAt;
		}
		public String getExcerpt() {
			return excerpt;
		}
		public void setExcerpt(String excerpt) {
			this.excerpt = excerpt;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public Integer getPageNumber() {
			return pageNumber;
		}
		public void setPageNumber(Integer pageNumber) {
			this.pageNumber = pageNumber;
		}

    }
	
	public static class PoemWithPageNumberDTO {
        private int id;
        private String title;
        private String textUrl;
        private Integer pageNumber;
		public PoemWithPageNumberDTO() {
			super();
			// TODO Auto-generated constructor stub
		}
		public PoemWithPageNumberDTO(int id,  String title, String textUrl, Integer pageNumber) {
			super();
			this.id = id;
			this.title = title;
			this.textUrl = textUrl;
			this.pageNumber = pageNumber;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getTextUrl() {
			return textUrl;
		}
		public void setTextUrl(String textUrl) {
			this.textUrl = textUrl;
		}
		public Integer getPageNumber() {
			return pageNumber;
		}
		public void setPageNumber(Integer pageNumber) {
			this.pageNumber = pageNumber;
		}
    }
	
}
