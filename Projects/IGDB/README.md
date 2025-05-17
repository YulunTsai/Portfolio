# 🎮 IGDB Game Insights Dashboard: Analyzing Ratings, Genres, and Popularity

This project explores relationships between game ratings, genres, and popularity using data retrieved from the IGDB API. The analysis is designed to demonstrate analytical and storytelling skills aligned with data analyst roles in the gaming industry.

**Note**: This project focuses on a filtered dataset of games that:
- Were released on **Windows (PC)** platform only
- Have a valid **popularity_score** from the IGDB API  
As a result, the findings are representative of **PC games with measurable popularity**, and may not generalize to console-exclusive or less-documented titles.

📌 **Project Overview**

**Goal**:To uncover insights into what makes games well-received and widely played by analyzing patterns across user ratings, critic scores, genres, and popularity metrics.

**Data Source**:
[IGDB (Internet Games Database)] via authenticated API requests.

**Data Dictionary**: [Google Sheet](https://docs.google.com/spreadsheets/d/1kmeJqPt9Pj5-R23CmSb-y3FqIO2gpkwiR-hccKsVG1g/edit?usp=sharing)

Workflow:

1. **Data Extraction** – Fetching structured data from multiple IGDB endpoints via API.

2. **Data Cleaning & Enrichment** – Converting foreign keys to human-readable values (e.g., genre names), handling missing data, and merging tables.

3. **Exploratory Data Analysis (EDA)** – Creating visualizations to reveal rating trends by year, genre behavior, and popularity anomalies.


📊 **Key Insights**

⭐ 1. Rating-Year Trends
[Average Ratings Per Year](https://github.com/YulunTsai/Portfolio/blob/main/Projects/IGDB/images/linechart_comparison_of_avg_ratings_per_year.png)
- All rating types show aligned trends over time (IGDB users, External, Total).
- Gradual decline in average ratings after 2000, with spikes every 4–5 years possibly due to console cycles or major franchise launches.

🧠 2. Genre vs. Rating Analysis
[Average Rating by Genre and Rating Type](https://github.com/YulunTsai/Portfolio/blob/main/Projects/IGDB/images/heatmap_avg_ratings_by_genre_and_source.png)
- RTS and Tactical games consistently rank high across user and critic ratings.
- TBS (Turn-Based Strategy) shows a gap between critics (high) and users (low), possibly due to poor spectator experience.
- Genres like Simulator, Puzzle, and Arcade have wide rating distributions—indicating volatility in game quality.

🔥 3. Popularity vs. Rating
[Total Rating v.s. Popularity Score](https://github.com/YulunTsai/Portfolio/blob/main/Projects/IGDB/images/scatterplot_popularity_score_vs_rating.png)
[Top 10 Overrhyped Games & Top 10 Underrated Games](https://github.com/YulunTsai/Portfolio/blob/main/Projects/IGDB/images/barchart_top10_overhyped_games.png)(https://github.com/YulunTsai/Portfolio/blob/main/Projects/IGDB/images/barchart_top10_underrated_games.png)
- Weak correlation between high popularity and high rating—overhyped games (high popularity, low rating) and underrated gems (low popularity, high rating) were identified.
- Scatter plots and bar charts help visualize the disconnect between what’s played and what’s well-reviewed.

📈 4. Popularity Type Patterns
[Genre vs. Popularity Type Distribution](https://github.com/YulunTsai/Portfolio/blob/main/Projects/IGDB/images/heatmap_%20relationship_of_genre_and_popularity_type.png)
Using IGDB’s popularity_type_id, we found that:
- MOBA games are highly popular by score, but lack variety in type-based popularity metrics.
- Played, Playing, and Visits dominate high-popularity genres.
- Valuable for studios to align launch strategies with the most active popularity indicators.

🧰 **Tools & Technologies**
Python: pandas, seaborn, matplotlib, requests
API Access: IGDB API (OAuth2.0 with Twitch credentials)
Notebook Environment: Google Colab

💡 **Future Extensions**
- Integrate Twitch/YouTube viewership data for cross-platform influence.
- Build interactive dashboards (e.g., Streamlit or Tableau Public).
- Include clustering models to segment game audience preferences.
