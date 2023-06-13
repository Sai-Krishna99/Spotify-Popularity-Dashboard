USE `Spotify_Music`;

INSERT INTO Spotify_Music.Record_company(    
Company_name)
(SELECT DISTINCT source
FROM
    spotify_data);
    
INSERT INTO Spotify_Music.Album(  
album_cover,  
release_date,
album_num_tracks,
Record_company_id)
(SELECT Distinct album_cover, release_date,album_num_tracks,Record_company_id
FROM
    spotify_data
LEFT JOIN Spotify_Music.Record_company
ON Spotify_Music.Record_company.Company_name = spotify_data.source);

INSERT INTO Spotify_Music.Music(    
Music_name,
Collab,
Duration,
Stream,
Weeks_on_chart,
Artist_num,
Album_id)
(SELECT track_name,collab,duration,streams,weeks_on_chart,artists_num,Album_id
FROM spotify_data
LEFT JOIN Spotify_Music.Album
ON Spotify_Music.Album.album_cover = Spotify_Music.spotify_data.album_cover
);

INSERT INTO Spotify_Music.Region(
Country,
Region,
Language)
(SELECT 
Distinct
country,
region, 
language
FROM
    spotify_data);
    

INSERT INTO Spotify_Music.Date(
Week_date)
(SELECT 
Distinct
week
FROM
    spotify_data);
    

INSERT INTO Spotify_Music.Rank(
music_rank,
Peak_rank,
Previous_rank,
Music_id)
(SELECT 
music_rank,
peak_rank,
previous_rank,
music_id
FROM
    spotify_data
LEFT JOIN Spotify_Music.Music
ON Spotify_Music.music.Music_name = spotify_data.track_name);
    

INSERT INTO Spotify_Music.Music_uri(
uri,
music_id)
(SELECT DISTINCT
uri,music_id
FROM
    spotify_data
LEFT JOIN Spotify_Music.music ON Spotify_Music.spotify_data.track_name = Spotify_Music.music.Music_name
    );

INSERT INTO Spotify_Music.Artist(
Artist_name,
Artist_img,
Artist_genre)
(SELECT 
Distinct
artist_individual,
artist_img,
artist_genre
FROM
    spotify_data);
    
INSERT INTO Spotify_Music.Artist_uri(
uri,
Artist_id)
(SELECT DISTINCT Spotify_Music.spotify_data.Artist_id,Spotify_Music.Artist.Artist_id
FROM
    spotify_data
LEFT JOIN Spotify_Music.Artist ON Spotify_Music.spotify_data.artist_individual = Spotify_Music.Artist.Artist_name
    );

INSERT INTO Spotify_Music.Music_date(
Music_id,
Date_id)
(SELECT 
Distinct
Music_id,
Date_id
FROM
    Spotify_Music.spotify_data
inner JOIN Spotify_Music.Music
ON Spotify_Music.music.Music_name = spotify_data.track_name
inner join Spotify_Music.Date
on Spotify_Music.Date.Week_date = spotify_data.week);

INSERT INTO Spotify_Music.Music_artist(
Music_id,
Artist_id)
(SELECT 
Distinct
Music_id,
Spotify_Music.Artist.Artist_id
FROM
    spotify_data
inner JOIN Spotify_Music.Music
ON Spotify_Music.music.Music_name = spotify_data.track_name
inner join Spotify_Music.Artist
on Spotify_Music.Artist.Artist_name = spotify_data.Artist_individual);
    
INSERT INTO Spotify_Music.Music_attribute(
Danceability,Energy,key_attribute,Mode,Loudness,Speechiness,Acousticness,Instrumentalness,Iiveness,Valence,Tempo,Music_id)
(SELECT danceability,energy,key_attribute,mode,loudness,speechiness,acousticness,instrumentalness,liveness,valence,tempo,music_id
FROM Spotify_Music.spotify_data
JOIN spotify_music.music on  Spotify_Music.music.Music_name = Spotify_Music.spotify_data.track_name
);

