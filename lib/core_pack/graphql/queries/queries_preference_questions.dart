class QueriesPreferenceQuestions {
  static String getPreferences() {
    return '''query{
	getPreferences {
		data {
			preferences {
						questionId
						description1
						description2
						backgroundImageUrl						
						multiChoice
						minNum
						options {
							imageUrl
							optionCode
							optionDesc							
						}
			}		
		}
			status{
				code
				description
			}
	}
}
''';
  }
}
