#!/usr/bin/env python
# 
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2

tournament = 1

def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament user='postgres' host='localhost' password='root'")


def deleteMatches():
    """Remove all the match records from the database."""
    conn = connect()
    cur = conn.cursor()
    cur.execute("DELETE FROM matches")
    cur.execute("DELETE FROM rounds")
    conn.commit()
    conn.close()


def deletePlayers():
    """Remove all the player records from the database."""
    conn = connect()
    cur = conn.cursor()
    cur.execute("DELETE FROM players")
    conn.commit()
    conn.close()

def countPlayers():
    """Returns the number of players currently registered.""" 
    conn = connect()
    cur = conn.cursor()
    cur.execute("""select count(*) as cant_players from \
        ( \
        select players.idplayer from matches \
        join players on matches.idplayer1 = players.idplayer or matches.idplayer2 = players.idplayer \
        where matches.idround in ( select rounds.idround from rounds where idtournament = %s) \
        group by players.idplayer \
        order by players.idplayer \
    ) as players_registered; 
    """, (tournament,))
    # getting the number of players
    data = cur.fetchall()
    data = int(data[0][0])
    conn.close()
    return data


def registerPlayer(name):
    """Adds a player to the tournament database.
  
    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)
  
    Args:
      name: the player's full name (need not be unique).
    """
    conn = connect()
    cur = conn.cursor()
    # default nationality is dominican
    nationality = "dom"
    cur.execute("INSERT INTO PLAYERS(name, nationality) VALUES (%s, %s)", (name, nationality))
    conn.commit()
    conn.close()


def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    conn = connect()
    cur = conn.cursor()
    query = """select p1.idplayer, p1.name, count(matches.winner) as cant_wins, max(games_played.cant_played) as cant_played from matches \
    right join players p1 on p1.idplayer = matches.winner \
    join (
        select players.idplayer, players.name, count(matches.idplayer1) as  cant_played  from matches \
        right join players on players.idplayer = matches.idplayer1 or players.idplayer = matches.idplayer2 \
        group by players.idplayer \
        order by players.idplayer \
         ) as games_played on p1.idplayer = games_played.idplayer \
    group by p1.idplayer \
    order by p1.idplayer; 
    """
    cur.execute(query)
    data = cur.fetchall()
    return data
    conn.close()


def reportMatch(winner, loser):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
 
 
def swissPairings():
    """Returns a list of pairs of players for the next round of a match.
  
    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.
  
    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """
print countPlayers()



