#!/usr/bin/env escript

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

%% TODO check tail call optimization implications

traverse_sections([Section | Rest], Output, SectionPosition, LessonPositon) ->
    {Lessons, ActualLessonPosition} =
        case Section of
            #{lessons := Lessons, reset_lesson_position := true} -> {Lessons, 1};
            #{lessons := Lessons} -> {Lessons, LessonPositon}
        end,

    {LessonsWithPostions, NextLessonPosition} = traverse_lessons(Lessons, [], ActualLessonPosition),
    SectionWithPositions = Section#{position => SectionPosition,
                                    lessons => LessonsWithPostions},

    traverse_sections(Rest, [SectionWithPositions | Output], SectionPosition + 1, NextLessonPosition);
traverse_sections([], Output, _, _) ->
    lists:reverse(Output).

traverse_lessons([Lesson | Rest], Output, LessonPosition) ->
    LessonWithPosition = Lesson#{position => LessonPosition},
    traverse_lessons(Rest, [LessonWithPosition | Output], LessonPosition + 1);
traverse_lessons([], Output, LastLessonPosition) ->
    {lists:reverse(Output), LastLessonPosition}.

main(_) ->
    Result = traverse_sections(?SECTIONS, [], 1, 1),
    io:format("~p", [Result]).
