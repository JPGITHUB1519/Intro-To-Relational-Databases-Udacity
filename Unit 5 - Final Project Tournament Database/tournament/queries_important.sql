
'Getting players registered in a tournament'
select * from tournaments_vs_players where idtournament = 1; 

'Getting players registered in all tournament'
select * from tournaments_vs_players 

'Getting the id of all players that played in all tournament'
select players.idplayer from matches
join players on matches.idplayer1 = players.idplayer or matches.idplayer2 = players.idplayer
group by players.idplayer
order by players.idplayer

'Getting the id of all players that played in rounds in one tournament'
select players.idplayer from matches
join players on matches.idplayer1 = players.idplayer or matches.idplayer2 = players.idplayer
where matches.idround in ( select rounds.idround from rounds where idtournament = 1)
group by players.idplayer
order by players.idplayer

'Getting cants of players in all tournaments'
select count(*) as cant_players from 
(
	select players.idplayer from matches
	join players on matches.idplayer1 = players.idplayer or matches.idplayer2 = players.idplayer
	group by players.idplayer
	order by players.idplayer
) as players_registered;

'Getting cants of players by tournament'
select count(*) as cant_players from 
(
	select players.idplayer from matches 
	join players on matches.idplayer1 = players.idplayer or matches.idplayer2 = players.idplayer
	where matches.idround in ( select rounds.idround from rounds where idtournament = 1)
	group by players.idplayer
	order by players.idplayer
) as players_registered;

'Getting all players names from a round'
select p1.name as player1, p2.name as player2 from matches
join players p1 on p1.idplayer = matches.idplayer1 
join players p2 on p2.idplayer = matches.idplayer2
where matches.idround = 1

'Getting all players from a round and his names and the winner and the looser'
select p1.name as player1, p2.name as player2, p3.name as winner, p4.name as looser
from matches
join players p1 on p1.idplayer = matches.idplayer1 
join players p2 on p2.idplayer = matches.idplayer2
join players p3 on p3.idplayer = matches.winner
join players p4 on p4.idplayer = matches.looser
where matches.idround = 1

'Getting winners players and cant'
select p1.idplayer, p1.name, count(matches.winner) as cant_wins from matches
right join players p1 on p1.idplayer = matches.winner
group by p1.idplayer
order by p1.idplayer;

'getting cants of games played by players'
select players.idplayer, players.name, count(matches.idplayer1) from matches
right join players on players.idplayer = matches.idplayer1 or players.idplayer = matches.idplayer2
group by players.idplayer
order by players.idplayer;

'Getting the name of players, the id the cants of wins and the cant of games played'
select p1.idplayer, p1.name, count(matches.winner) as cant_wins, max(games_played.cant_played) as cant_played from matches
right join players p1 on p1.idplayer = matches.winner
join (
	select players.idplayer, players.name, count(matches.idplayer1) as  cant_played  from matches
	right join players on players.idplayer = matches.idplayer1 or players.idplayer = matches.idplayer2
	group by players.idplayer
	order by players.idplayer
     ) as games_played on p1.idplayer = games_played.idplayer
group by p1.idplayer
order by p1.idplayer;

