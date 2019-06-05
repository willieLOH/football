defmodule FootballWeb.MatchView do
  use FootballWeb, :view
  alias FootballWeb.MatchView

  def render("index.json", %{matches: matches}) do
    %{data: render_many(matches, MatchView, "match.json")}
  end

  def render("show.json", %{match: match}) do
    %{data: render_one(match, MatchView, "match.json")}
  end

  def render("match.json", %{match: match}) do
    %{id: match.id,
      division: match.division,
      season: match.season,
      match_date: match.match_date,
      home_team: match.home_team,
      away_team: match.away_team,
      fthg: match.fthg,
      ftag: match.ftag,
      ftr: match.ftr,
      hthg: match.hthg,
      htag: match.htag,
      htr: match.htr}
  end

  def render("matches.proto", %{matches: matches}) do
    [matches: Enum.map(matches, &parse_proto/1)]
    |> FootballWeb.Protobuf.Messages.Matches.new()
    |> FootballWeb.Protobuf.Messages.Matches.encode()
  end

  def render("match.proto", %{match: match}) do
    match
    |> parse_proto()
    |> FootballWeb.Protobuf.Messages.Match.encode()
  end

  defp parse_proto(match) do
    FootballWeb.Protobuf.Messages.Match.new(%{
      id: match.id,
      division: match.division,
      season: match.season,
      match_date: Date.to_iso8601(match.match_date),
      home_team: match.home_team,
      away_team: match.away_team,
      fthg: match.fthg,
      ftag: match.ftag,
      ftr: match.ftr,
      hthg: match.hthg,
      htag: match.htag,
      htr: match.htr
    })
  end
end
