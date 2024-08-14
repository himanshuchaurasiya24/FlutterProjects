// To parse this JSON data, do
//
//     final modelClass = modelClassFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

ModelClass modelClassFromJson(String str) => ModelClass.fromJson(json.decode(str));

String modelClassToJson(ModelClass data) => json.encode(data.toJson());

class ModelClass {
    Data data;
    Extensions extensions;
    String status;

    ModelClass({
        required this.data,
        required this.extensions,
        required this.status,
    });

    factory ModelClass.fromJson(Map<String, dynamic> json) => ModelClass(
        data: Data.fromJson(json["data"]),
        extensions: Extensions.fromJson(json["extensions"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "extensions": extensions.toJson(),
        "status": status,
    };
}

class Data {
    ShortcodeMedia shortcodeMedia;

    Data({
        required this.shortcodeMedia,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        shortcodeMedia: ShortcodeMedia.fromJson(json["shortcode_media"]),
    );

    Map<String, dynamic> toJson() => {
        "shortcode_media": shortcodeMedia.toJson(),
    };
}

class ShortcodeMedia {
    Typename typename;
    String id;
    String shortcode;
    Dimensions dimensions;
    dynamic gatingInfo;
    dynamic factCheckOverallRating;
    dynamic factCheckInformation;
    dynamic sensitivityFrictionInfo;
    SharingFrictionInfo sharingFrictionInfo;
    dynamic mediaOverlayInfo;
    String mediaPreview;
    String displayUrl;
    List<DisplayResource> displayResources;
    dynamic accessibilityCaption;
    DashInfo dashInfo;
    bool hasAudio;
    String videoUrl;
    int videoViewCount;
    int videoPlayCount;
    bool isVideo;
    String trackingToken;
    dynamic upcomingEvent;
    EdgeMediaToCaptionClass edgeMediaToTaggedUser;
    EdgeMediaToCaptionClass edgeMediaToCaption;
    bool canSeeInsightsAsBrand;
    bool captionIsEdited;
    bool hasRankedComments;
    bool likeAndViewCountsDisabled;
    EdgeMediaToParentCommentClass edgeMediaToParentComment;
    EdgeMediaToCaptionClass edgeMediaToHoistedComment;
    EdgeMediaPreview edgeMediaPreviewComment;
    bool commentsDisabled;
    bool commentingDisabledForViewer;
    int takenAtTimestamp;
    EdgeMediaPreview edgeMediaPreviewLike;
    EdgeMediaToCaptionClass edgeMediaToSponsorUser;
    bool isAffiliate;
    bool isPaidPartnership;
    dynamic location;
    dynamic nftAssetInfo;
    bool viewerHasLiked;
    bool viewerHasSaved;
    bool viewerHasSavedToCollection;
    bool viewerInPhotoOfYou;
    bool viewerCanReshare;
    ShortcodeMediaOwner owner;
    bool isAd;
    EdgeMediaToCaptionClass edgeWebMediaToRelatedMedia;
    List<dynamic> coauthorProducers;
    List<dynamic> pinnedForUsers;
    dynamic encodingStatus;
    bool isPublished;
    String productType;
    String title;
    double videoDuration;
    String thumbnailSrc;
    ClipsMusicAttributionInfo clipsMusicAttributionInfo;
    EdgeRelatedProfiles edgeRelatedProfiles;

    ShortcodeMedia({
        required this.typename,
        required this.id,
        required this.shortcode,
        required this.dimensions,
        required this.gatingInfo,
        required this.factCheckOverallRating,
        required this.factCheckInformation,
        required this.sensitivityFrictionInfo,
        required this.sharingFrictionInfo,
        required this.mediaOverlayInfo,
        required this.mediaPreview,
        required this.displayUrl,
        required this.displayResources,
        required this.accessibilityCaption,
        required this.dashInfo,
        required this.hasAudio,
        required this.videoUrl,
        required this.videoViewCount,
        required this.videoPlayCount,
        required this.isVideo,
        required this.trackingToken,
        required this.upcomingEvent,
        required this.edgeMediaToTaggedUser,
        required this.edgeMediaToCaption,
        required this.canSeeInsightsAsBrand,
        required this.captionIsEdited,
        required this.hasRankedComments,
        required this.likeAndViewCountsDisabled,
        required this.edgeMediaToParentComment,
        required this.edgeMediaToHoistedComment,
        required this.edgeMediaPreviewComment,
        required this.commentsDisabled,
        required this.commentingDisabledForViewer,
        required this.takenAtTimestamp,
        required this.edgeMediaPreviewLike,
        required this.edgeMediaToSponsorUser,
        required this.isAffiliate,
        required this.isPaidPartnership,
        required this.location,
        required this.nftAssetInfo,
        required this.viewerHasLiked,
        required this.viewerHasSaved,
        required this.viewerHasSavedToCollection,
        required this.viewerInPhotoOfYou,
        required this.viewerCanReshare,
        required this.owner,
        required this.isAd,
        required this.edgeWebMediaToRelatedMedia,
        required this.coauthorProducers,
        required this.pinnedForUsers,
        required this.encodingStatus,
        required this.isPublished,
        required this.productType,
        required this.title,
        required this.videoDuration,
        required this.thumbnailSrc,
        required this.clipsMusicAttributionInfo,
        required this.edgeRelatedProfiles,
    });

    factory ShortcodeMedia.fromJson(Map<String, dynamic> json) => ShortcodeMedia(
        typename: typenameValues.map[json["__typename"]]!,
        id: json["id"],
        shortcode: json["shortcode"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        gatingInfo: json["gating_info"],
        factCheckOverallRating: json["fact_check_overall_rating"],
        factCheckInformation: json["fact_check_information"],
        sensitivityFrictionInfo: json["sensitivity_friction_info"],
        sharingFrictionInfo: SharingFrictionInfo.fromJson(json["sharing_friction_info"]),
        mediaOverlayInfo: json["media_overlay_info"],
        mediaPreview: json["media_preview"],
        displayUrl: json["display_url"],
        displayResources: List<DisplayResource>.from(json["display_resources"].map((x) => DisplayResource.fromJson(x))),
        accessibilityCaption: json["accessibility_caption"],
        dashInfo: DashInfo.fromJson(json["dash_info"]),
        hasAudio: json["has_audio"],
        videoUrl: json["video_url"],
        videoViewCount: json["video_view_count"],
        videoPlayCount: json["video_play_count"],
        isVideo: json["is_video"],
        trackingToken: json["tracking_token"],
        upcomingEvent: json["upcoming_event"],
        edgeMediaToTaggedUser: EdgeMediaToCaptionClass.fromJson(json["edge_media_to_tagged_user"]),
        edgeMediaToCaption: EdgeMediaToCaptionClass.fromJson(json["edge_media_to_caption"]),
        canSeeInsightsAsBrand: json["can_see_insights_as_brand"],
        captionIsEdited: json["caption_is_edited"],
        hasRankedComments: json["has_ranked_comments"],
        likeAndViewCountsDisabled: json["like_and_view_counts_disabled"],
        edgeMediaToParentComment: EdgeMediaToParentCommentClass.fromJson(json["edge_media_to_parent_comment"]),
        edgeMediaToHoistedComment: EdgeMediaToCaptionClass.fromJson(json["edge_media_to_hoisted_comment"]),
        edgeMediaPreviewComment: EdgeMediaPreview.fromJson(json["edge_media_preview_comment"]),
        commentsDisabled: json["comments_disabled"],
        commentingDisabledForViewer: json["commenting_disabled_for_viewer"],
        takenAtTimestamp: json["taken_at_timestamp"],
        edgeMediaPreviewLike: EdgeMediaPreview.fromJson(json["edge_media_preview_like"]),
        edgeMediaToSponsorUser: EdgeMediaToCaptionClass.fromJson(json["edge_media_to_sponsor_user"]),
        isAffiliate: json["is_affiliate"],
        isPaidPartnership: json["is_paid_partnership"],
        location: json["location"],
        nftAssetInfo: json["nft_asset_info"],
        viewerHasLiked: json["viewer_has_liked"],
        viewerHasSaved: json["viewer_has_saved"],
        viewerHasSavedToCollection: json["viewer_has_saved_to_collection"],
        viewerInPhotoOfYou: json["viewer_in_photo_of_you"],
        viewerCanReshare: json["viewer_can_reshare"],
        owner: ShortcodeMediaOwner.fromJson(json["owner"]),
        isAd: json["is_ad"],
        edgeWebMediaToRelatedMedia: EdgeMediaToCaptionClass.fromJson(json["edge_web_media_to_related_media"]),
        coauthorProducers: List<dynamic>.from(json["coauthor_producers"].map((x) => x)),
        pinnedForUsers: List<dynamic>.from(json["pinned_for_users"].map((x) => x)),
        encodingStatus: json["encoding_status"],
        isPublished: json["is_published"],
        productType: json["product_type"],
        title: json["title"],
        videoDuration: json["video_duration"]?.toDouble(),
        thumbnailSrc: json["thumbnail_src"],
        clipsMusicAttributionInfo: ClipsMusicAttributionInfo.fromJson(json["clips_music_attribution_info"]),
        edgeRelatedProfiles: EdgeRelatedProfiles.fromJson(json["edge_related_profiles"]),
    );

    Map<String, dynamic> toJson() => {
        "__typename": typenameValues.reverse[typename],
        "id": id,
        "shortcode": shortcode,
        "dimensions": dimensions.toJson(),
        "gating_info": gatingInfo,
        "fact_check_overall_rating": factCheckOverallRating,
        "fact_check_information": factCheckInformation,
        "sensitivity_friction_info": sensitivityFrictionInfo,
        "sharing_friction_info": sharingFrictionInfo.toJson(),
        "media_overlay_info": mediaOverlayInfo,
        "media_preview": mediaPreview,
        "display_url": displayUrl,
        "display_resources": List<dynamic>.from(displayResources.map((x) => x.toJson())),
        "accessibility_caption": accessibilityCaption,
        "dash_info": dashInfo.toJson(),
        "has_audio": hasAudio,
        "video_url": videoUrl,
        "video_view_count": videoViewCount,
        "video_play_count": videoPlayCount,
        "is_video": isVideo,
        "tracking_token": trackingToken,
        "upcoming_event": upcomingEvent,
        "edge_media_to_tagged_user": edgeMediaToTaggedUser.toJson(),
        "edge_media_to_caption": edgeMediaToCaption.toJson(),
        "can_see_insights_as_brand": canSeeInsightsAsBrand,
        "caption_is_edited": captionIsEdited,
        "has_ranked_comments": hasRankedComments,
        "like_and_view_counts_disabled": likeAndViewCountsDisabled,
        "edge_media_to_parent_comment": edgeMediaToParentComment.toJson(),
        "edge_media_to_hoisted_comment": edgeMediaToHoistedComment.toJson(),
        "edge_media_preview_comment": edgeMediaPreviewComment.toJson(),
        "comments_disabled": commentsDisabled,
        "commenting_disabled_for_viewer": commentingDisabledForViewer,
        "taken_at_timestamp": takenAtTimestamp,
        "edge_media_preview_like": edgeMediaPreviewLike.toJson(),
        "edge_media_to_sponsor_user": edgeMediaToSponsorUser.toJson(),
        "is_affiliate": isAffiliate,
        "is_paid_partnership": isPaidPartnership,
        "location": location,
        "nft_asset_info": nftAssetInfo,
        "viewer_has_liked": viewerHasLiked,
        "viewer_has_saved": viewerHasSaved,
        "viewer_has_saved_to_collection": viewerHasSavedToCollection,
        "viewer_in_photo_of_you": viewerInPhotoOfYou,
        "viewer_can_reshare": viewerCanReshare,
        "owner": owner.toJson(),
        "is_ad": isAd,
        "edge_web_media_to_related_media": edgeWebMediaToRelatedMedia.toJson(),
        "coauthor_producers": List<dynamic>.from(coauthorProducers.map((x) => x)),
        "pinned_for_users": List<dynamic>.from(pinnedForUsers.map((x) => x)),
        "encoding_status": encodingStatus,
        "is_published": isPublished,
        "product_type": productType,
        "title": title,
        "video_duration": videoDuration,
        "thumbnail_src": thumbnailSrc,
        "clips_music_attribution_info": clipsMusicAttributionInfo.toJson(),
        "edge_related_profiles": edgeRelatedProfiles.toJson(),
    };
}

class ClipsMusicAttributionInfo {
    String artistName;
    String songName;
    bool usesOriginalAudio;
    bool shouldMuteAudio;
    String shouldMuteAudioReason;
    String audioId;

    ClipsMusicAttributionInfo({
        required this.artistName,
        required this.songName,
        required this.usesOriginalAudio,
        required this.shouldMuteAudio,
        required this.shouldMuteAudioReason,
        required this.audioId,
    });

    factory ClipsMusicAttributionInfo.fromJson(Map<String, dynamic> json) => ClipsMusicAttributionInfo(
        artistName: json["artist_name"],
        songName: json["song_name"],
        usesOriginalAudio: json["uses_original_audio"],
        shouldMuteAudio: json["should_mute_audio"],
        shouldMuteAudioReason: json["should_mute_audio_reason"],
        audioId: json["audio_id"],
    );

    Map<String, dynamic> toJson() => {
        "artist_name": artistName,
        "song_name": songName,
        "uses_original_audio": usesOriginalAudio,
        "should_mute_audio": shouldMuteAudio,
        "should_mute_audio_reason": shouldMuteAudioReason,
        "audio_id": audioId,
    };
}

class DashInfo {
    bool isDashEligible;
    dynamic videoDashManifest;
    int numberOfQualities;

    DashInfo({
        required this.isDashEligible,
        required this.videoDashManifest,
        required this.numberOfQualities,
    });

    factory DashInfo.fromJson(Map<String, dynamic> json) => DashInfo(
        isDashEligible: json["is_dash_eligible"],
        videoDashManifest: json["video_dash_manifest"],
        numberOfQualities: json["number_of_qualities"],
    );

    Map<String, dynamic> toJson() => {
        "is_dash_eligible": isDashEligible,
        "video_dash_manifest": videoDashManifest,
        "number_of_qualities": numberOfQualities,
    };
}

class Dimensions {
    int height;
    int width;

    Dimensions({
        required this.height,
        required this.width,
    });

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        height: json["height"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
    };
}

class DisplayResource {
    String src;
    int configWidth;
    int configHeight;

    DisplayResource({
        required this.src,
        required this.configWidth,
        required this.configHeight,
    });

    factory DisplayResource.fromJson(Map<String, dynamic> json) => DisplayResource(
        src: json["src"],
        configWidth: json["config_width"],
        configHeight: json["config_height"],
    );

    Map<String, dynamic> toJson() => {
        "src": src,
        "config_width": configWidth,
        "config_height": configHeight,
    };
}

class EdgeMediaPreview {
    int count;
    List<EdgeMediaPreviewCommentEdge> edges;

    EdgeMediaPreview({
        required this.count,
        required this.edges,
    });

    factory EdgeMediaPreview.fromJson(Map<String, dynamic> json) => EdgeMediaPreview(
        count: json["count"],
        edges: List<EdgeMediaPreviewCommentEdge>.from(json["edges"].map((x) => EdgeMediaPreviewCommentEdge.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
    };
}

class EdgeMediaToParentCommentClass {
    int count;
    PageInfo pageInfo;
    List<EdgeMediaPreviewCommentEdge> edges;

    EdgeMediaToParentCommentClass({
        required this.count,
        required this.pageInfo,
        required this.edges,
    });

    factory EdgeMediaToParentCommentClass.fromJson(Map<String, dynamic> json) => EdgeMediaToParentCommentClass(
        count: json["count"],
        pageInfo: PageInfo.fromJson(json["page_info"]),
        edges: List<EdgeMediaPreviewCommentEdge>.from(json["edges"].map((x) => EdgeMediaPreviewCommentEdge.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "page_info": pageInfo.toJson(),
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
    };
}

class PurpleNode {
    String id;
    String text;
    int createdAt;
    bool didReportAsSpam;
    PurpleOwner owner;
    bool viewerHasLiked;
    EdgeFollowedByClass edgeLikedBy;
    bool isRestrictedPending;
    EdgeMediaToParentCommentClass? edgeThreadedComments;

    PurpleNode({
        required this.id,
        required this.text,
        required this.createdAt,
        required this.didReportAsSpam,
        required this.owner,
        required this.viewerHasLiked,
        required this.edgeLikedBy,
        required this.isRestrictedPending,
        this.edgeThreadedComments,
    });

    factory PurpleNode.fromJson(Map<String, dynamic> json) => PurpleNode(
        id: json["id"],
        text: json["text"],
        createdAt: json["created_at"],
        didReportAsSpam: json["did_report_as_spam"],
        owner: PurpleOwner.fromJson(json["owner"]),
        viewerHasLiked: json["viewer_has_liked"],
        edgeLikedBy: EdgeFollowedByClass.fromJson(json["edge_liked_by"]),
        isRestrictedPending: json["is_restricted_pending"],
        edgeThreadedComments: json["edge_threaded_comments"] == null ? null : EdgeMediaToParentCommentClass.fromJson(json["edge_threaded_comments"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "created_at": createdAt,
        "did_report_as_spam": didReportAsSpam,
        "owner": owner.toJson(),
        "viewer_has_liked": viewerHasLiked,
        "edge_liked_by": edgeLikedBy.toJson(),
        "is_restricted_pending": isRestrictedPending,
        "edge_threaded_comments": edgeThreadedComments?.toJson(),
    };
}

class EdgeMediaPreviewCommentEdge {
    PurpleNode node;

    EdgeMediaPreviewCommentEdge({
        required this.node,
    });

    factory EdgeMediaPreviewCommentEdge.fromJson(Map<String, dynamic> json) => EdgeMediaPreviewCommentEdge(
        node: PurpleNode.fromJson(json["node"]),
    );

    Map<String, dynamic> toJson() => {
        "node": node.toJson(),
    };
}

class PageInfo {
    bool hasNextPage;
    String? endCursor;

    PageInfo({
        required this.hasNextPage,
        required this.endCursor,
    });

    factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        hasNextPage: json["has_next_page"],
        endCursor: json["end_cursor"],
    );

    Map<String, dynamic> toJson() => {
        "has_next_page": hasNextPage,
        "end_cursor": endCursor,
    };
}

class EdgeFollowedByClass {
    int count;

    EdgeFollowedByClass({
        required this.count,
    });

    factory EdgeFollowedByClass.fromJson(Map<String, dynamic> json) => EdgeFollowedByClass(
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
    };
}

class PurpleOwner {
    String id;
    bool isVerified;
    String profilePicUrl;
    String username;

    PurpleOwner({
        required this.id,
        required this.isVerified,
        required this.profilePicUrl,
        required this.username,
    });

    factory PurpleOwner.fromJson(Map<String, dynamic> json) => PurpleOwner(
        id: json["id"],
        isVerified: json["is_verified"],
        profilePicUrl: json["profile_pic_url"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "is_verified": isVerified,
        "profile_pic_url": profilePicUrl,
        "username": username,
    };
}

class EdgeMediaToCaptionClass {
    List<EdgeMediaToCaptionEdge> edges;

    EdgeMediaToCaptionClass({
        required this.edges,
    });

    factory EdgeMediaToCaptionClass.fromJson(Map<String, dynamic> json) => EdgeMediaToCaptionClass(
        edges: List<EdgeMediaToCaptionEdge>.from(json["edges"].map((x) => EdgeMediaToCaptionEdge.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
    };
}

class EdgeMediaToCaptionEdge {
    FluffyNode node;

    EdgeMediaToCaptionEdge({
        required this.node,
    });

    factory EdgeMediaToCaptionEdge.fromJson(Map<String, dynamic> json) => EdgeMediaToCaptionEdge(
        node: FluffyNode.fromJson(json["node"]),
    );

    Map<String, dynamic> toJson() => {
        "node": node.toJson(),
    };
}

class FluffyNode {
    String createdAt;
    String text;

    FluffyNode({
        required this.createdAt,
        required this.text,
    });

    factory FluffyNode.fromJson(Map<String, dynamic> json) => FluffyNode(
        createdAt: json["created_at"]??'',
        text: json["text"]??'',
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "text": text,
    };
}

class EdgeRelatedProfiles {
    List<EdgeRelatedProfilesEdge> edges;

    EdgeRelatedProfiles({
        required this.edges,
    });

    factory EdgeRelatedProfiles.fromJson(Map<String, dynamic> json) => EdgeRelatedProfiles(
        edges: List<EdgeRelatedProfilesEdge>.from(json["edges"].map((x) => EdgeRelatedProfilesEdge.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
    };
}

class EdgeRelatedProfilesEdge {
    TentacledNode node;

    EdgeRelatedProfilesEdge({
        required this.node,
    });

    factory EdgeRelatedProfilesEdge.fromJson(Map<String, dynamic> json) => EdgeRelatedProfilesEdge(
        node: TentacledNode.fromJson(json["node"]),
    );

    Map<String, dynamic> toJson() => {
        "node": node.toJson(),
    };
}

class TentacledNode {
    String id;
    String fullName;
    bool isPrivate;
    bool isVerified;
    String profilePicUrl;
    String username;
    EdgeFollowedByClass edgeFollowedBy;
    EdgeOwnerToTimelineMedia edgeOwnerToTimelineMedia;

    TentacledNode({
        required this.id,
        required this.fullName,
        required this.isPrivate,
        required this.isVerified,
        required this.profilePicUrl,
        required this.username,
        required this.edgeFollowedBy,
        required this.edgeOwnerToTimelineMedia,
    });

    factory TentacledNode.fromJson(Map<String, dynamic> json) => TentacledNode(
        id: json["id"],
        fullName: json["full_name"],
        isPrivate: json["is_private"],
        isVerified: json["is_verified"],
        profilePicUrl: json["profile_pic_url"],
        username: json["username"],
        edgeFollowedBy: EdgeFollowedByClass.fromJson(json["edge_followed_by"]),
        edgeOwnerToTimelineMedia: EdgeOwnerToTimelineMedia.fromJson(json["edge_owner_to_timeline_media"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "is_private": isPrivate,
        "is_verified": isVerified,
        "profile_pic_url": profilePicUrl,
        "username": username,
        "edge_followed_by": edgeFollowedBy.toJson(),
        "edge_owner_to_timeline_media": edgeOwnerToTimelineMedia.toJson(),
    };
}

class EdgeOwnerToTimelineMedia {
    int count;
    List<EdgeOwnerToTimelineMediaEdge> edges;

    EdgeOwnerToTimelineMedia({
        required this.count,
        required this.edges,
    });

    factory EdgeOwnerToTimelineMedia.fromJson(Map<String, dynamic> json) => EdgeOwnerToTimelineMedia(
        count: json["count"],
        edges: List<EdgeOwnerToTimelineMediaEdge>.from(json["edges"].map((x) => EdgeOwnerToTimelineMediaEdge.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
    };
}

class EdgeOwnerToTimelineMediaEdge {
    StickyNode node;

    EdgeOwnerToTimelineMediaEdge({
        required this.node,
    });

    factory EdgeOwnerToTimelineMediaEdge.fromJson(Map<String, dynamic> json) => EdgeOwnerToTimelineMediaEdge(
        node: StickyNode.fromJson(json["node"]),
    );

    Map<String, dynamic> toJson() => {
        "node": node.toJson(),
    };
}

class StickyNode {
    Typename typename;
    String id;
    String shortcode;
    EdgeFollowedByClass edgeMediaPreviewLike;
    EdgeFollowedByClass edgeMediaPreviewComment;
    String thumbnailSrc;
    FluffyOwner owner;
    dynamic gatingInfo;
    SharingFrictionInfo sharingFrictionInfo;
    dynamic mediaOverlayInfo;
    bool isVideo;
    String? accessibilityCaption;

    StickyNode({
        required this.typename,
        required this.id,
        required this.shortcode,
        required this.edgeMediaPreviewLike,
        required this.edgeMediaPreviewComment,
        required this.thumbnailSrc,
        required this.owner,
        required this.gatingInfo,
        required this.sharingFrictionInfo,
        required this.mediaOverlayInfo,
        required this.isVideo,
        required this.accessibilityCaption,
    });

    factory StickyNode.fromJson(Map<String, dynamic> json) => StickyNode(
        typename: typenameValues.map[json["__typename"]]!,
        id: json["id"],
        shortcode: json["shortcode"],
        edgeMediaPreviewLike: EdgeFollowedByClass.fromJson(json["edge_media_preview_like"]),
        edgeMediaPreviewComment: EdgeFollowedByClass.fromJson(json["edge_media_preview_comment"]),
        thumbnailSrc: json["thumbnail_src"],
        owner: FluffyOwner.fromJson(json["owner"]),
        gatingInfo: json["gating_info"],
        sharingFrictionInfo: SharingFrictionInfo.fromJson(json["sharing_friction_info"]),
        mediaOverlayInfo: json["media_overlay_info"],
        isVideo: json["is_video"],
        accessibilityCaption: json["accessibility_caption"],
    );

    Map<String, dynamic> toJson() => {
        "__typename": typenameValues.reverse[typename],
        "id": id,
        "shortcode": shortcode,
        "edge_media_preview_like": edgeMediaPreviewLike.toJson(),
        "edge_media_preview_comment": edgeMediaPreviewComment.toJson(),
        "thumbnail_src": thumbnailSrc,
        "owner": owner.toJson(),
        "gating_info": gatingInfo,
        "sharing_friction_info": sharingFrictionInfo.toJson(),
        "media_overlay_info": mediaOverlayInfo,
        "is_video": isVideo,
        "accessibility_caption": accessibilityCaption,
    };
}

class FluffyOwner {
    String id;
    String username;

    FluffyOwner({
        required this.id,
        required this.username,
    });

    factory FluffyOwner.fromJson(Map<String, dynamic> json) => FluffyOwner(
        id: json["id"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
    };
}

class SharingFrictionInfo {
    bool shouldHaveSharingFriction;
    dynamic bloksAppUrl;

    SharingFrictionInfo({
        required this.shouldHaveSharingFriction,
        required this.bloksAppUrl,
    });

    factory SharingFrictionInfo.fromJson(Map<String, dynamic> json) => SharingFrictionInfo(
        shouldHaveSharingFriction: json["should_have_sharing_friction"],
        bloksAppUrl: json["bloks_app_url"],
    );

    Map<String, dynamic> toJson() => {
        "should_have_sharing_friction": shouldHaveSharingFriction,
        "bloks_app_url": bloksAppUrl,
    };
}

enum Typename {
    GRAPH_IMAGE,
    GRAPH_SIDECAR,
    GRAPH_VIDEO
}

final typenameValues = EnumValues({
    "GraphImage": Typename.GRAPH_IMAGE,
    "GraphSidecar": Typename.GRAPH_SIDECAR,
    "GraphVideo": Typename.GRAPH_VIDEO
});

class ShortcodeMediaOwner {
    String id;
    bool isVerified;
    String profilePicUrl;
    String username;
    bool blockedByViewer;
    dynamic restrictedByViewer;
    bool followedByViewer;
    String fullName;
    bool hasBlockedViewer;
    bool isEmbedsDisabled;
    bool isPrivate;
    bool isUnpublished;
    bool requestedByViewer;
    bool passTieringRecommendation;
    EdgeFollowedByClass edgeOwnerToTimelineMedia;
    EdgeFollowedByClass edgeFollowedBy;

    ShortcodeMediaOwner({
        required this.id,
        required this.isVerified,
        required this.profilePicUrl,
        required this.username,
        required this.blockedByViewer,
        required this.restrictedByViewer,
        required this.followedByViewer,
        required this.fullName,
        required this.hasBlockedViewer,
        required this.isEmbedsDisabled,
        required this.isPrivate,
        required this.isUnpublished,
        required this.requestedByViewer,
        required this.passTieringRecommendation,
        required this.edgeOwnerToTimelineMedia,
        required this.edgeFollowedBy,
    });

    factory ShortcodeMediaOwner.fromJson(Map<String, dynamic> json) => ShortcodeMediaOwner(
        id: json["id"],
        isVerified: json["is_verified"],
        profilePicUrl: json["profile_pic_url"],
        username: json["username"],
        blockedByViewer: json["blocked_by_viewer"],
        restrictedByViewer: json["restricted_by_viewer"],
        followedByViewer: json["followed_by_viewer"],
        fullName: json["full_name"],
        hasBlockedViewer: json["has_blocked_viewer"],
        isEmbedsDisabled: json["is_embeds_disabled"],
        isPrivate: json["is_private"],
        isUnpublished: json["is_unpublished"],
        requestedByViewer: json["requested_by_viewer"],
        passTieringRecommendation: json["pass_tiering_recommendation"],
        edgeOwnerToTimelineMedia: EdgeFollowedByClass.fromJson(json["edge_owner_to_timeline_media"]),
        edgeFollowedBy: EdgeFollowedByClass.fromJson(json["edge_followed_by"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "is_verified": isVerified,
        "profile_pic_url": profilePicUrl,
        "username": username,
        "blocked_by_viewer": blockedByViewer,
        "restricted_by_viewer": restrictedByViewer,
        "followed_by_viewer": followedByViewer,
        "full_name": fullName,
        "has_blocked_viewer": hasBlockedViewer,
        "is_embeds_disabled": isEmbedsDisabled,
        "is_private": isPrivate,
        "is_unpublished": isUnpublished,
        "requested_by_viewer": requestedByViewer,
        "pass_tiering_recommendation": passTieringRecommendation,
        "edge_owner_to_timeline_media": edgeOwnerToTimelineMedia.toJson(),
        "edge_followed_by": edgeFollowedBy.toJson(),
    };
}

class Extensions {
    bool isFinal;

    Extensions({
        required this.isFinal,
    });

    factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(
        isFinal: json["is_final"],
    );

    Map<String, dynamic> toJson() => {
        "is_final": isFinal,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
