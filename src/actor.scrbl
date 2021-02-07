#lang scribble/manual

@title{Actor}

This page treats of actors and the way they are implemented.

@section{Structure}

@racketblock[
 (concrete-actor name
                 location
                 mailbox
                 type)
 name: raart?
 location: pair?
 mailbox: list-msg?
 type: symbol?
]

Creates a @italic{concrete-actor}.

The @italic{name} argument is the raart shown by the buffer.

The @italic{location} argument is a pair indicating the location of the actor.

The @italic{mailbox} argument is a list of messages which are sent to the actor in order to change its state.

The @italic{type} argument is a symbol indicating the type of the actor in order to ease the treatment of actors and know what message send. There are four type of actors :
@itemlist[@item{ally ship,}
          @item{ally missile,}
          @item{ennemy ship,}
          @item{ennemy missile.}]

@section{Predicates}

@racketblock[
 (msg? msg) -> boolean
 msg: any/c]

Predicate saying if @italic{msg} is a message or not.

@racketblock[
 (list-msg? l) -> boolean
 l: any/c]

Predicate saying if @italic{l} is a list of messages or not.

@racketblock[
 (list-actor? l) -> boolean
 l: any/c]

Predicate saying if @italic{l} is a list of actors.

@racketblock[
 (actor-type? actor
              type) ->boolean
 actor: concrete-actor?
 type: symbol?]

Predicate saying if the type of the @italic{actor} and @italic{type} are the same.

@section{Fonctions}

This part presents many functions that deals actors.

@subsection{Feilds of the structure}

@racketblock[
 (actor-mailbox actor) -> list-msg?
 actor: concrete-actor?]

Fonction which returns the mailbox of @italic{actor}.

@racketblock[
 (actor-location actor) -> pair?
 actor: concrete-actor?]

Fonction which returns the location of @italic{actor}.

@racketblock[
 (actor-type actor) -> symbol?
 actor: concrete-actor?]

Fonction which returns the type of @italic{actor}.

@subsection{Functions that modify actors}

@racketblock[
 (actor-send actor
             message) -> concrete-actor?
 actor: concrete-actor?
 message: msg?]

Function that send a message to an actor.

The @italic{actor} parameter indicate the actor recepient.

The @italic{message} is the message sent.

@racketblock[
 (actor-update actor) -> list-actor?
 actor: concrete-actor?]

Function that empty the mailbox and update the actor consequently and return a list of actors containing the one update and ones that maybe created during the update.

The @italic{actor} parameter indicate the actor updated.
