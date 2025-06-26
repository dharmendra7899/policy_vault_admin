class AppUrls {
  static String get liveBaseUrl => 'https://api.policyvault.in';

  static String get localBaseUrl => 'https://api.policyvault.in';

  static String get mainBaseUrl => '$liveBaseUrl/api/v1.0';
  static String get secondaryBaseUrl => 'https//:policy.com/api/v1.0';

  ///user apis end points
  static String get sendOTPEndPoint => '/users/generateotp/';

  static String get verifyOTPEndPoint => '/users/verifyotp/';

  static String get deleteAccountEndPoint => '/users/delete_user/';

  static String get getProfileEndPoint => '/users/get_user_profile/';

  static String get addProfileEndPoint => '/users/addprofile/';

  static String get policyListEndPoint => '/users/user_all_detail/';

  ///add documents
  static String get addDocumentsEndPoint => '/users/add_document/';

  ///master apis end points
  static String get getInsuranceEndPoint => '/master/get_insurence_type_list/';

  static String get getCompaniesEndPoint =>'/master/get_insurence_company_list/';

  static String get searchCompaniesEndPoint =>'/master/search_insurence_company/';

  static String get faqsEndPoint => '/master/get_faq_list/';

  static String get aboutUsEndPoint => '/master/get_aboutus_list/';

  static String get addSupportEndPoint => '/support/add/';

  ///policies
  static String get memberListEndPoint => '/policy/member_list/';

  static String get addMemberEndPoint => '/policy/add_member/';

  static String get deleteMemberEndPoint => '/policy/delete_member/';

  static String get addNoteEndPoint => '/}policy/add_note/';

  static String get addPolicyEndPoint => '/policy/addpolicy/';

  static String get sharedMemberEndPoint => '/policy/shared_member_list/';

  static String get sharedPolicyToMemberEndPoint => '/policy/share_policy_member/';

  static String get removeSharedPolicyToMemberEndPoint => '/policy/remove_share_policy/';

  static String get policyDocumentEndPoint => '/policy/documentlist/';

  static String get addPolicyDocumentEndPoint => '/policy/add_document/';

  static String get deletePolicyDocumentEndPoint => '/policy/deletedocument/';
}
