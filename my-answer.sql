-- Task: Heaviest Hitters Award
-- Find the team with the highest average weight of batters in a given year.

SELECT AVG(p.weight) AS average_weight, t.name AS team_name, b.yearid
FROM people AS p
INNER JOIN batting AS b ON p.playerid = b.playerid
INNER JOIN teams AS t ON b.team_id = t.id
GROUP BY t.name, b.yearid
ORDER BY average_weight DESC;

-- Task: Shortest Sluggers Award
-- Find the team with the smallest average height of batters in a given year.

SELECT AVG(p.height) AS average_height, t.name AS team_name, b.yearid
FROM people AS p
INNER JOIN batting AS b ON p.playerid = b.playerid
INNER JOIN teams AS t ON b.team_id = t.id
GROUP BY t.name, b.yearid
ORDER BY average_height ASC;

-- Task: Biggest Spenders Award
-- Find the team with the largest total salary of all players in a given year.

SELECT SUM(s.salary) AS total_salary, t.name AS team_name, s.yearid
FROM salaries AS s
LEFT JOIN teams AS t ON s.teamid = t.teamid AND s.yearid = t.yearid
GROUP BY t.name, s.yearid
ORDER BY total_salary DESC;

-- Task: Most Bang For Their Buck in 2010 Award
-- Find the team with the smallest "cost per win" in 2010.

SELECT ROUND(SUM(s.salary) / t.w) AS cost_per_win, t.w AS wins, t.name AS team_name, s.yearid
FROM salaries AS s
LEFT JOIN teams AS t ON s.teamid = t.teamid AND s.yearid = t.yearid
WHERE t.yearid = 2010
GROUP BY t.name, s.yearid, t.w
ORDER BY cost_per_win ASC;

-- Task: Priciest Starters Award
-- Find the pitcher who, in a given year, cost the most money per game started (at least 10 games started).

SELECT p.namefirst, p.namelast, s.salary / p.g AS cost_per_game, s.yearid, p.g AS games_started
FROM salaries AS s
INNER JOIN pitching AS p ON s.playerid = p.playerid AND s.yearid = p.yearid AND s.teamid = p.teamid
INNER JOIN people AS p ON s.playerid = p.playerid
WHERE p.g > 10
ORDER BY cost_per_game DESC;
