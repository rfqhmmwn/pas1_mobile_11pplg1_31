class Welcome {
  final String idTeam;
  final String strTeam;
  final String? strTeamBadge;
  
  Welcome({
    required this.idTeam,
    required this.strTeam,
    this.strTeamBadge,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
      idTeam: json['idTeam'].toString(),
      strTeam: json['strTeam'] ?? '',
      strTeamBadge: json['strTeamBadge'],
    );
  }

  Map<String, dynamic> toJson() => {
    'idTeam': idTeam,
    'strTeam': strTeam,
    'strTeamBadge': strTeamBadge,
  };
}