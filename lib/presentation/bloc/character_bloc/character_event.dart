part of 'character_bloc.dart';

@immutable
sealed class CharacterEvent {}

final class LoadCharacters extends CharacterEvent {}

class ReloadCharacters extends CharacterEvent {}