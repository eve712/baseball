package com.team22.baseball.dto.response;


import com.fasterxml.jackson.annotation.JsonProperty;

public class GameDto {

    @JsonProperty("game_id")
    private Long gameId;

    @JsonProperty("in_Progress")
    private boolean inProgress;

    @JsonProperty("home")
    private String home;

    @JsonProperty("away")
    private String away;

    public GameDto(Long gameId, boolean inProgress, String home, String away) {
        this.gameId = gameId;
        this.inProgress = inProgress;
        this.home = home;
        this.away = away;
    }

    public Long getGameId() {
        return gameId;
    }

    public boolean isInProgress() {
        return inProgress;
    }

    public String getHome() {
        return home;
    }

    public String getAway() {
        return away;
    }

    public void setGameId(Long gameId) {
        this.gameId = gameId;
    }

    public void setInProgress(boolean inProgress) {
        this.inProgress = inProgress;
    }

    public void setHome(String home) {
        this.home = home;
    }

    public void setAway(String away) {
        this.away = away;
    }
}
