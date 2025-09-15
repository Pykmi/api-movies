-- ================================
-- Seed data for movies & actors
-- ================================

-- === Avengers: Endgame ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Anthony', 'Russo', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Robert', 'Downey Jr.', 'ACTOR'),
  ('Chris', 'Evans', 'ACTOR'),
  ('Scarlett', 'Johansson', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Avengers: Endgame',
  2018,
  12,
  4,
  'After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos'' actions and restore balance to the universe.',
  (SELECT id FROM people WHERE first_name = 'Anthony' AND last_name = 'Russo' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Avengers: Endgame' AND (
  (p.first_name = 'Robert' AND p.last_name = 'Downey Jr.') OR
  (p.first_name = 'Chris' AND p.last_name = 'Evans') OR
  (p.first_name = 'Scarlett' AND p.last_name = 'Johansson')
);

-- === The Curse of the Were-Rabbit ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Steve', 'Box', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Peter', 'Sallis', 'ACTOR'),
  ('Ralph', 'Fiennes', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'The Curse of the Were-Rabbit',
  2005,
  12,
  4,
  'Wallace and his loyal dog, Gromit, set out to discover the mystery behind the garden sabotage that plagues their village and threatens the annual giant vegetable growing contest.',
  (SELECT id FROM people WHERE first_name = 'Steve' AND last_name = 'Box' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'The Curse of the Were-Rabbit' AND (
  (p.first_name = 'Peter' AND p.last_name = 'Sallis') OR
  (p.first_name = 'Ralph' AND p.last_name = 'Fiennes')
);

-- === Downtown Abbey ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Michael', 'Enger', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Michelle', 'Dockery', 'ACTOR'),
  ('Matthew', 'Goode', 'ACTOR'),
  ('Tuppence', 'Middleton', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Downtown Abbey',
  2019,
  7,
  3,
  'The continuing story of the Crawley family, wealthy owners of a large estate in the English countryside in the early 20th century.',
  (SELECT id FROM people WHERE first_name = 'Michael' AND last_name = 'Enger' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Downtown Abbey' AND (
  (p.first_name = 'Michelle' AND p.last_name = 'Dockery') OR
  (p.first_name = 'Matthew' AND p.last_name = 'Goode') OR
  (p.first_name = 'Tuppence' AND p.last_name = 'Middleton')
);

-- === Ad Astra ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('James', 'Grey', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Brad', 'Pitt', 'ACTOR'),
  ('Tommy', 'Lee Jones', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Ad Astra',
  2019,
  12,
  3,
  'Astronaut Roy McBride undertakes a mission across an unforgiving solar system to uncover the truth about his missing father and his doomed expedition that now, 30 years later, threatens the universe.',
  (SELECT id FROM people WHERE first_name = 'James' AND last_name = 'Grey' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Ad Astra' AND (
  (p.first_name = 'Brad' AND p.last_name = 'Pitt') OR
  (p.first_name = 'Tommy' AND p.last_name = 'Lee Jones')
);

-- === The Dark Crystal ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Jim', 'Henson', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Jim', 'Henson', 'ACTOR'),
  ('Catherine', 'Mullen', 'ACTOR'),
  ('Frank', 'Oz', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'The Dark Crystal',
  1982,
  12,
  3,
  'On another planet in the distant past, a Gelfling embarks on a quest to find the missing shard of a magical crystal, and so restore order to his world.',
  (SELECT id FROM people WHERE first_name = 'Jim' AND last_name = 'Henson' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'The Dark Crystal' AND (
  (p.first_name = 'Jim' AND p.last_name = 'Henson' AND p.type = 'ACTOR') OR
  (p.first_name = 'Catherine' AND p.last_name = 'Mullen') OR
  (p.first_name = 'Frank' AND p.last_name = 'Oz')
);

-- === Aliens ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('James', 'Cameron', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Sigourney', 'Weaver', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Aliens',
  1986,
  16,
  5,
  'Ellen Ripley is rescued by a deep salvage team after being in hypersleep for 57 years. The moon that the Nostromo visited has been colonized, but contact is lost. This time, colonial marines have impressive firepower, but will that be enough?',
  (SELECT id FROM people WHERE first_name = 'James' AND last_name = 'Cameron' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Aliens' AND (
  (p.first_name = 'Sigourney' AND p.last_name = 'Weaver')
);

-- === 2001: A Space Odyssey ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Stanley', 'Kubrick', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Keir', 'Dullea', 'ACTOR'),
  ('Gary', 'Lockwood', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  '2001: A Space Odyssey',
  1986,
  8,
  5,
  'After discovering a mysterious artifact buried beneath the Lunar surface, mankind sets off on a quest to find its origins with help from intelligent supercomputer H.A.L. 9000.',
  (SELECT id FROM people WHERE first_name = 'Stanley' AND last_name = 'Kubrick' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = '2001: A Space Odyssey' AND (
  (p.first_name = 'Keir' AND p.last_name = 'Dullea') OR
  (p.first_name = 'Gary' AND p.last_name = 'Lockwood')
);

-- === Tolkien ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Dome', 'Karkukoski', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Nicholas', 'Dullea', 'ACTOR'),
  ('Lily', 'Collins', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Tolkien',
  2019,
  12,
  2,
  'The formative years of the orphaned author J.R.R. Tolkien as he finds friendship, love and artistic inspiration among a group of fellow outcasts at school.',
  (SELECT id FROM people WHERE first_name = 'Dome' AND last_name = 'Karkukoski' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Tolkien' AND (
  (p.first_name = 'Nicholas' AND p.last_name = 'Dullea') OR
  (p.first_name = 'Lily' AND p.last_name = 'Collins')
);

-- === The Shape of Water ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Guillermo', 'del Toro', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Sally', 'Hawkins', 'ACTOR'),
  ('Michael', 'Shannon', 'ACTOR'),
  ('Octavia', 'Spencer', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'The Shape of Water',
  2017,
  16,
  4,
  'At a top secret research facility in the 1960s, a lonely janitor forms a unique relationship with an amphibious creature that is being held in captivity.',
  (SELECT id FROM people WHERE first_name = 'Guillermo' AND last_name = 'del Toro' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'The Shape of Water' AND (
  (p.first_name = 'Sally' AND p.last_name = 'Hawkins') OR
  (p.first_name = 'Michael' AND p.last_name = 'Shannon') OR
  (p.first_name = 'Octavia' AND p.last_name = 'Spencer')
);

-- === Vertigo ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Alfred', 'Hitchcock', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('James', 'Stewart', 'ACTOR'),
  ('Kim', 'Novak', 'ACTOR'),
  ('Barbara', 'Bel Geddes', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Vertigo',
  1958,
  12,
  5,
  'A former police detective juggles wrestling with his personal demons and becoming obsessed with a hauntingly beautiful woman.',
  (SELECT id FROM people WHERE first_name = 'Alfred' AND last_name = 'Hitchcock' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Vertigo' AND (
  (p.first_name = 'James' AND p.last_name = 'Stewart') OR
  (p.first_name = 'Kim' AND p.last_name = 'Novak') OR
  (p.first_name = 'Barbara' AND p.last_name = 'Bel Geddes')
);

-- === Blade Runner 2049 ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Denis', 'Villeneuve', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Ryan', 'Gosling', 'ACTOR'),
  ('Harrison', 'Ford', 'ACTOR'),
  ('Robin', 'Wright', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Blade Runner 2049',
  2017,
  15,
  5,
  'A young blade runner''s discovery of a long-buried secret leads him to track down former blade runner Rick Deckard, who''s been missing for thirty years.',
  (SELECT id FROM people WHERE first_name = 'Denis' AND last_name = 'Villeneuve' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Blade Runner 2049' AND (
  (p.first_name = 'Ryan' AND p.last_name = 'Gosling') OR
  (p.first_name = 'Harrison' AND p.last_name = 'Ford') OR
  (p.first_name = 'Robin' AND p.last_name = 'Wright')
);

-- === Drive ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Nicholas', 'Winding Refn', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Ryan', 'Gosling', 'ACTOR'),
  ('Carey', 'Mulligan', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Drive',
  2011,
  18,
  4,
  'A mysterious Hollywood stuntman and mechanic moonlights as a getaway driver and finds himself in trouble when he helps out his neighbor.',
  (SELECT id FROM people WHERE first_name = 'Nicholas' AND last_name = 'Winding Refn' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Drive' AND (
  (p.first_name = 'Ryan' AND p.last_name = 'Gosling') OR
  (p.first_name = 'Carey' AND p.last_name = 'Mulligan')
);

-- === Dumb and Dumber ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Peter', 'Farrelly', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Jim', 'Carrey', 'ACTOR'),
  ('Jeff', 'Daniels', 'ACTOR'),
  ('Lauren', 'Holly', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Dumb and Dumber',
  1994,
  12,
  3,
  'After a woman leaves a briefcase at the airport terminal, a dumb limo driver and his dumber friend set out on a hilarious cross-country road trip to Aspen, to return the briefcase to its owner.',
  (SELECT id FROM people WHERE first_name = 'Peter' AND last_name = 'Farrelly' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Dumb and Dumber' AND (
  (p.first_name = 'Jim' AND p.last_name = 'Carrey') OR
  (p.first_name = 'Jeff' AND p.last_name = 'Daniels') OR
  (p.first_name = 'Lauren' AND p.last_name = 'Holly')
);

-- === Raiders of the Lost Ark ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Steven', 'Spielberg', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Harrison', 'Ford', 'ACTOR'),
  ('Karen', 'Allen', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Raiders of the Lost Ark',
  1981,
  0,
  4,
  'In 1936, archaeologist and adventurer Indiana Jones is hired by the U.S. government to find the Ark of the Covenant before Adolf Hitler''s Nazis can obtain its awesome powers.',
  (SELECT id FROM people WHERE first_name = 'Steven' AND last_name = 'Spielberg' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Raiders of the Lost Ark' AND (
  (p.first_name = 'Harrison' AND p.last_name = 'Ford') OR
  (p.first_name = 'Karen' AND p.last_name = 'Allen')
);

-- === Gremlins ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Joe', 'Dante', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Hoyt', 'Axton', 'ACTOR'),
  ('John', 'Louie', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Gremlins',
  1984,
  15,
  3,
  'A boy inadvertently breaks three important rules concerning his new pet and unleashes a horde of malevolently mischievous monsters on a small town.',
  (SELECT id FROM people WHERE first_name = 'Joe' AND last_name = 'Dante' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Gremlins' AND (
  (p.first_name = 'Hoyt' AND p.last_name = 'Axton') OR
  (p.first_name = 'John' AND p.last_name = 'Louie')
);

-- === The Florida Project ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Sean', 'Baker', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Brooklynn', 'Prince', 'ACTOR'),
  ('Christopher', 'Rivera', 'ACTOR'),
  ('Willem', 'Dafoe', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'The Florida Project',
  2017,
  15,
  3,
  'Set over one summer, the film follows precocious six-year-old Moonee as she courts mischief and adventure with her ragtag playmates and bonds with her rebellious but caring mother, all while living in the shadows of Walt Disney World.',
  (SELECT id FROM people WHERE first_name = 'Sean' AND last_name = 'Baker' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'The Florida Project' AND (
  (p.first_name = 'Brooklynn' AND p.last_name = 'Prince') OR
  (p.first_name = 'Christopher' AND p.last_name = 'Rivera') OR
  (p.first_name = 'Willem' AND p.last_name = 'Dafoe')
);

-- === Predator ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('John', 'McTiernan', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Arnold', 'Schwarzenegger', 'ACTOR'),
  ('Carl', 'Weathers', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Predator',
  1987,
  18,
  4,
  'A team of commandos on a mission in a Central American jungle find themselves hunted by an extraterrestrial warrior.',
  (SELECT id FROM people WHERE first_name = 'John' AND last_name = 'McTiernan' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Predator' AND (
  (p.first_name = 'Arnold' AND p.last_name = 'Schwarzenegger') OR
  (p.first_name = 'Carl' AND p.last_name = 'Weathers')
);

-- === Spirited Away ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Hayao', 'Miyazaki', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Rumi', 'Hiiragi', 'ACTOR'),
  ('Miyu', 'Irino', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Spirited Away',
  2001,
  0,
  5,
  'During her family''s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.',
  (SELECT id FROM people WHERE first_name = 'Hayao' AND last_name = 'Miyazaki' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Spirited Away' AND (
  (p.first_name = 'Rumi' AND p.last_name = 'Hiiragi') OR
  (p.first_name = 'Miyu' AND p.last_name = 'Irino')
);

-- === Saving Private Ryan ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Steven', 'Spielberg', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Tom', 'Hanks', 'ACTOR'),
  ('Tom', 'Sizemore', 'ACTOR'),
  ('Edward', 'Burns', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Saving Private Ryan',
  1998,
  15,
  3,
  'Following the Normandy Landings, a group of U.S. soldiers go behind enemy lines to retrieve a paratrooper whose brothers have been killed in action.',
  (SELECT id FROM people WHERE first_name = 'Steven' AND last_name = 'Spielberg' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Saving Private Ryan' AND (
  (p.first_name = 'Tom' AND p.last_name = 'Hanks') OR
  (p.first_name = 'Tom' AND p.last_name = 'Sizemore') OR
  (p.first_name = 'Edward' AND p.last_name = 'Burns')
);

-- === Rambo: Last Blood ===
INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Adrian', 'Grunberg', 'DIRECTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.people (first_name, last_name, type) VALUES
  ('Sylvester', 'Stallone', 'ACTOR'),
  ('Paz', 'Vega', 'ACTOR'),
  ('Yvette', 'Monreal', 'ACTOR')
ON CONFLICT DO NOTHING;

INSERT INTO public.movies (name, year, age_limit, rating, synopsis, director_id)
VALUES (
  'Rambo: Last Blood',
  2019,
  18,
  2,
  'Rambo must confront his past and unearth his ruthless combat skills to exact revenge in a final mission.',
  (SELECT id FROM people WHERE first_name = 'Adrian' AND last_name = 'Grunberg' AND type = 'DIRECTOR')
);

INSERT INTO public.movie_actors (movie_id, person_id)
SELECT m.id, p.id
FROM movies m, people p
WHERE m.name = 'Rambo: Last Blood' AND (
  (p.first_name = 'Sylvester' AND p.last_name = 'Stallone') OR
  (p.first_name = 'Paz' AND p.last_name = 'Vega') OR
  (p.first_name = 'Yvette' AND p.last_name = 'Monreal')
);
