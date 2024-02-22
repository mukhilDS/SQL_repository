-- Dataset: Top 50 songs of 2023 (spotify)
-- Source: https://www.kaggle.com/datasets/yukawithdata/spotify-top-tracks-2023
-- Using: PostgreSQL

/* pitch-class integer notation: reference on "Key" and "Mode" Columns
https://smbutterfield.github.io/ibmt17-18/22-intro-to-non-diatonic-materials/b2-tx-pcintnotation.html*/

SELECT * FROM spotify;

-- 1. Find the top 10 longest songs in top 50 list
SELECT artist_name,track_name,duration_ms
FROM spotify
ORDER BY duration_ms DESC
LIMIT 10;

-- 2. Find the top 10 most popular songs in Top 50
SELECT artist_name,track_name,popularity
FROM spotify
ORDER BY popularity DESC
LIMIT 10;

-- 3. Find the old songs which has made a comeback in 2023
SELECT track_name,artist_name,album_release_date
FROM spotify
WHERE album_release_date < '2023-01-01';

-- 4. Find the tracks with less energy than average 
SELECT * FROM spotify
where ENERGY < (select avg(energy) from spotify);

-- 5. Find the artists with more than one song in top 50's
SELECT artist_name, count(track_name) songs
FROM spotify
GROUP BY artist_name
HAVING count(track_name) > 1
order by songs DESC;


-- 6. Find the top 10 most energetic artists
SELECT artist_name, round(avg(energy),3) artist_energy
FROM spotify
GROUP BY artist_name
order by artist_energy DESC
limit 10; 

-- 7. What is muscial note in each song?
/* key - C, C#, D, D#, E, F, F#, G, G#, A, A#, B (labelled from 0 to 11 respectively)
mode - major or minor scale (labelled 1 and 0 respectively */
SELECT
    track_name,
    artist_name,
    CASE
        WHEN key = 0 AND mode = 1 THEN 'C Major'
        WHEN key = 0 AND mode = 0 THEN 'C Minor'
        WHEN key = 1 AND mode = 1 THEN 'C#/Db Major'
        WHEN key = 1 AND mode = 0 THEN 'C#/Db Minor'
        WHEN key = 2 AND mode = 1 THEN 'D Major'
        WHEN key = 2 AND mode = 0 THEN 'D Minor'
        WHEN key = 3 AND mode = 1 THEN 'D#/Eb Major'
        WHEN key = 3 AND mode = 0 THEN 'D#/Eb Minor'
        WHEN key = 4 AND mode = 1 THEN 'E Major'
        WHEN key = 4 AND mode = 0 THEN 'E Minor'
        WHEN key = 5 AND mode = 1 THEN 'F Major'
        WHEN key = 5 AND mode = 0 THEN 'F Minor'
        WHEN key = 6 AND mode = 1 THEN 'F#/Gb Major'
        WHEN key = 6 AND mode = 0 THEN 'F#/Gb Minor'
        WHEN key = 7 AND mode = 1 THEN 'G Major'
        WHEN key = 7 AND mode = 0 THEN 'G Minor'
        WHEN key = 8 AND mode = 1 THEN 'G#/Ab Major'
        WHEN key = 8 AND mode = 0 THEN 'G#/Ab Minor'
        WHEN key = 9 AND mode = 1 THEN 'A Major'
        WHEN key = 9 AND mode = 0 THEN 'A Minor'
        WHEN key = 10 AND mode = 1 THEN 'A#/Bb Major'
        WHEN key = 10 AND mode = 0 THEN 'A#/Bb Minor'
        WHEN key = 11 AND mode = 1 THEN 'B Major'
        WHEN key = 11 AND mode = 0 THEN 'B Minor'
    END AS key
FROM spotify;

-- 8. Add a new column to the sportify table
ALTER TABLE spotify
ADD COLUMN Note VARCHAR(20); -- Adjust the VARCHAR size according to your needs

UPDATE spotify
SET Note = CASE
        WHEN key = 0 AND mode = 1 THEN 'C Major'
        WHEN key = 0 AND mode = 0 THEN 'C Minor'
        WHEN key = 1 AND mode = 1 THEN 'C#/Db Major'
        WHEN key = 1 AND mode = 0 THEN 'C#/Db Minor'
        WHEN key = 2 AND mode = 1 THEN 'D Major'
        WHEN key = 2 AND mode = 0 THEN 'D Minor'
        WHEN key = 3 AND mode = 1 THEN 'D#/Eb Major'
        WHEN key = 3 AND mode = 0 THEN 'D#/Eb Minor'
        WHEN key = 4 AND mode = 1 THEN 'E Major'
        WHEN key = 4 AND mode = 0 THEN 'E Minor'
        WHEN key = 5 AND mode = 1 THEN 'F Major'
        WHEN key = 5 AND mode = 0 THEN 'F Minor'
        WHEN key = 6 AND mode = 1 THEN 'F#/Gb Major'
        WHEN key = 6 AND mode = 0 THEN 'F#/Gb Minor'
        WHEN key = 7 AND mode = 1 THEN 'G Major'
        WHEN key = 7 AND mode = 0 THEN 'G Minor'
        WHEN key = 8 AND mode = 1 THEN 'G#/Ab Major'
        WHEN key = 8 AND mode = 0 THEN 'G#/Ab Minor'
        WHEN key = 9 AND mode = 1 THEN 'A Major'
        WHEN key = 9 AND mode = 0 THEN 'A Minor'
        WHEN key = 10 AND mode = 1 THEN 'A#/Bb Major'
        WHEN key = 10 AND mode = 0 THEN 'A#/Bb Minor'
        WHEN key = 11 AND mode = 1 THEN 'B Major'
        WHEN key = 11 AND mode = 0 THEN 'B Minor'
    END;


-- 9. Find all the songs with "C Major" note
SELECT *
FROM spotify
WHERE note = 'C Major';

-- 10. Find songs that have more energy, danceability and loudness than average
SELECT *
FROM spotify
WHERE danceability > (SELECT AVG(danceability) FROM spotify)
and energy > (SELECT AVG(energy) FROM spotify)
and loudness > (SELECT AVG(loudness) FROM spotify);

-- 11. Find the top 10 songs with liveness (multiple people in recording)
SELECT *
FROM spotify
ORDER BY liveness DESC
LIMIT 10;

-- 12. Find the 10 most acoustic songs
SELECT *
FROM spotify
ORDER BY acousticness DESC
LIMIT 10;

-- 13. Top 10 Songs with most spoken words
SELECT *
FROM spotify
ORDER BY speechiness
LIMIT 10;

-- 14. Common Key note in the Top 50
SELECT note, count(*) count_songs
FROM spotify
GROUP BY note
ORDER BY count(*) DESC
LIMIT 10;

-- 15. Populariy of each Key note with multiple songs in top 50
SELECT note,count(*) as count_songs, ROUND(AVG(popularity),2) popularity
FROM spotify
GROUP BY note
HAVING count(*)>1
ORDER BY popularity DESC
LIMIT 10;


