import Foundation

extension SportAPI {
    enum Parameter: String {
        case accessToken
        case domain
        case username
        case password
        case clientId = "client_id"
        case grantType = "grant_type"
        case groupType
        case status
        case perPage
        case organizationId
        case priorities
        case categories
        case hours
        case assignmentType
        case formId
        case refreshToken = "refresh_token"
        // TODO: questionable metric name id
        case metricNameId = "metricNameId[]"
        case userId
        case days
        case context
        case date
        case cursor
        case key = "key[]"
        case entityType
        case deliveryType = "deliveryTypes[]"
        case entityIds = "entityIds[]"
        case kinductUserCuid
        case tenantId
        case userAccessToken
        case userAccessTokenSecret
    }
}
