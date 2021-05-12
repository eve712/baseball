import GameCard from "./GameCard";
import { useState, useEffect } from "react";
import styled from "styled-components";

const GameList = () => {
  const [games, setGames] = useState([]);
  useEffect(() => {
    // API로 불러옴
    const planningDocumentGames = [
      ["captain", "marvel"],
      ["twins", "tigers"],
      ["rockets", "dodgers"],
      ["captain", "marvel"],
      ["twins", "tigers"],
      ["rockets", "dodgers"],
      ["captain", "marvel"],
      ["twins", "tigers"],
      ["rockets", "dodgers"],
      ["captain", "marvel"],
      ["twins", "tigers"],
      ["rockets", "dodgers"],
    ];
    setGames(planningDocumentGames);
  }, []);

  return (
    <GameListLayout>
      {games.map((game, idx) => (
        <GameCard key={`gameCard-${idx}`} game={game} idx={idx + 1} />
      ))}
    </GameListLayout>
  );
};

const GameListLayout = styled.div`
  width: 60%;
  height: 33vh;
  display: flex;
  flex-direction: column;
  margin-top: 5%;
  overflow: hidden;

  &:hover {
    overflow-y: scroll;
  }
`;
export default GameList;