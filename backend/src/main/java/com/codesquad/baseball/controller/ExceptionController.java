package com.codesquad.baseball.controller;

import com.codesquad.baseball.dto.etc.ErrorDTO;
import com.codesquad.baseball.exceptions.game.GameAlreadyOccupiedException;
import com.codesquad.baseball.exceptions.game.GameIsNotStartedException;
import com.codesquad.baseball.exceptions.notfound.GameNotFoundException;
import com.codesquad.baseball.exceptions.notfound.NotFoundException;
import com.codesquad.baseball.exceptions.notfound.PlayerNotFoundException;
import com.codesquad.baseball.exceptions.notfound.TeamNotFoundException;
import com.codesquad.baseball.exceptions.oauth.InvalidJwtTokenException;
import com.codesquad.baseball.exceptions.oauth.NoJwtTokenException;
import org.springframework.http.HttpStatus;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ExceptionController {

    @ResponseStatus(HttpStatus.CONFLICT)
    @ExceptionHandler(GameAlreadyOccupiedException.class)
    public ErrorDTO handleGameAlreadyOccupiedException(GameAlreadyOccupiedException exception) {
        return new ErrorDTO(HttpStatus.CONFLICT, exception.getMessage());
    }

    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler({PlayerNotFoundException.class, TeamNotFoundException.class, GameNotFoundException.class})
    public ErrorDTO handlePlayerNotFoundException(NotFoundException exception) {
        return new ErrorDTO(HttpStatus.NOT_FOUND, exception.getMessage());
    }

    @ResponseStatus(HttpStatus.CONFLICT)
    @ExceptionHandler(GameIsNotStartedException.class)
    public ErrorDTO handleGameIsNotStartedException(GameIsNotStartedException exception) {
        return new ErrorDTO(HttpStatus.CONFLICT, exception.getMessage());
    }


    @ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ErrorDTO handleInternalServerError(HttpRequestMethodNotSupportedException exception) {
        return new ErrorDTO(HttpStatus.METHOD_NOT_ALLOWED, exception.getMessage());
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler({NoJwtTokenException.class, InvalidJwtTokenException.class})
    public ErrorDTO handleNoJwtTokenException(RuntimeException exception) {
        return new ErrorDTO(HttpStatus.BAD_REQUEST, exception.getMessage());
    }
}
