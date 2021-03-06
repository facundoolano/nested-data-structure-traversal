#!/usr/bin/env escript
-mode(compile).

-define(SECTIONS, [
    #{
        title => "Getting started",
        reset_lesson_position => false,
        lessons => [
            #{name => "Welcome"},
            #{name => "Installation"}
        ]
    },

    #{
        title => "Basic operator",
        reset_lesson_position => false,
        lessons => [
            #{name => "Addition / Subtraction"},
            #{name => "Multiplication / Division"}
        ]
    },

    #{
        title => "Advanced topics",
        reset_lesson_position => true,
        lessons => [
            #{name => "Mutability"},
            #{name => "Immutability"}
        ]
    }
]).

traverse_sections(Sections) ->
    {Output, _, _} =
        lists:foldl(
          fun (Section, {Output, SectionPosition, LessonPosition}) ->
                  #{lessons := Lessons, reset_lesson_position := ResetPosition} = Section,
                  {LessonsWithPostions, NextLessonPosition} =
                      traverse_lessons(Lessons, LessonPosition, ResetPosition),
                  SectionWithPositions = Section#{position => SectionPosition,
                                                  lessons => LessonsWithPostions},
                  {[SectionWithPositions | Output], SectionPosition + 1, NextLessonPosition}
          end, {[], 1, 1}, Sections),
    lists:reverse(Output).

traverse_lessons(Lessons, LessonPosition, _Reset=false) ->
    traverse_lessons(Lessons, LessonPosition);
traverse_lessons(Lessons, _LessonPosition, _Reset=true) ->
    traverse_lessons(Lessons, 1).

traverse_lessons(Lessons, FirstLessonPosition) ->
    {Output, LastLessonPosition} =
        lists:foldl(
          fun(Lesson, {Output, LessonPosition}) ->
                  LessonWithPosition = Lesson#{position => LessonPosition},
                  {[LessonWithPosition | Output], LessonPosition + 1}
          end,
          {[], FirstLessonPosition}, Lessons),
    {lists:reverse(Output), LastLessonPosition}.

main(_) ->
    Result = traverse_sections(?SECTIONS),
    io:format("~p", [Result]).
