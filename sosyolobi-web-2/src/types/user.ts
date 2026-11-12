export enum ActivityStatus {
  Open = 1,
  Full = 2,
  Completed = 3,
  Cancelled = 4,
}

export enum ActivityRequestStatus {
  Pending = 1,
  Approved = 2,
  Rejected = 3,
  Cancelled = 4,
}

export enum SkillLevel {
  Any = 0,
  Beginner = 1,
  Intermediate = 2,
  Advanced = 3,
}

export enum GenderPreference {
  Any = 0,
  Male = 1,
  Female = 2,
  Mixed = 3,
}

export enum ChatRoomStatus {
  Open = 1,
  Closed = 2,
}

export enum FriendRequestStatus {
  Pending = 1,
  Accepted = 2,
  Rejected = 3,
  Cancelled = 4,
}

export interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
}

export interface PagedResponse<T> {
  items: T[];
  totalCount: number;
  page: number;
  pageSize: number;
  totalPages: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
}

export interface UserAuthResponse {
  accessToken: string;
  refreshToken: string;
  expiresAt: string;
  userId: string;
  role: string;
  displayName?: string;
  isNewUser: boolean;
}

export interface UserTokenPayload {
  sub: string;
  role: string;
  displayName?: string;
  exp: number;
}

export interface Category {
  id: string;
  name: string;
  slug: string;
  iconName?: string;
  color?: string;
  imageUrl?: string;
  sortOrder: number;
}

export interface Activity {
  id: string;
  createdByUserId: string;
  createdByDisplayName: string;
  createdByAvatarUrl?: string;
  categoryId: string;
  categoryName: string;
  categoryImageUrl?: string;
  title: string;
  description?: string;
  eventDate: string;
  neededPeopleCount: number;
  currentPeopleCount: number;
  pricePerPerson?: number;
  skillLevel: SkillLevel;
  genderPreference: GenderPreference;
  status: ActivityStatus;
  latitude: number;
  longitude: number;
  addressText: string;
  distanceMeters?: number;
  createdAt: string;
}

export interface ActivityDetail extends Activity {
  addressDetailPrivate?: string;
  participants: PublicProfile[];
  myRequestStatus?: ActivityRequestStatus | null;
}

export interface ActivityMapItem {
  id: string;
  title: string;
  categoryName: string;
  categoryImageUrl?: string;
  status: ActivityStatus;
  latitude: number;
  longitude: number;
  eventDate: string;
  neededPeopleCount: number;
  pricePerPerson?: number;
  distanceMeters: number;
}

export interface UserProfile {
  userId: string;
  displayName: string;
  bio?: string;
  avatarUrl?: string;
  birthDate?: string;
  averageRating: number;
  reviewCount: number;
  completedActivityCount: number;
  isPhoneVerified: boolean;
  createdAt: string;
}

export interface PublicProfile {
  userId: string;
  displayName: string;
  bio?: string;
  avatarUrl?: string;
  averageRating: number;
  reviewCount: number;
  completedActivityCount: number;
}

export interface ActivityJoinRequest {
  id: string;
  activityId: string;
  user: PublicProfile;
  message?: string;
  status: ActivityRequestStatus;
  createdAt: string;
  respondedAt?: string;
}

export interface FriendRequest {
  id: string;
  status: FriendRequestStatus;
  createdAt: string;
  respondedAt?: string;
  user: PublicProfile;
}

export interface Friend {
  friendsSinceUtc: string;
  user: PublicProfile;
}

export interface ChatRoom {
  id: string;
  activityId: string;
  status: ChatRoomStatus;
  createdAt: string;
  closedAt?: string;
}

export interface ChatMessageReplyPreview {
  id: string;
  senderDisplayName: string;
  content: string;
}

export interface ChatMessage {
  id: string;
  chatRoomId: string;
  senderUserId: string;
  senderDisplayName: string;
  senderAvatarUrl?: string;
  content: string;
  replyTo?: ChatMessageReplyPreview;
  createdAt: string;
}

export interface Notification {
  id: string;
  type: number;
  title: string;
  message?: string;
  relatedActivityId?: string;
  relatedActivityTitle?: string;
  isRead: boolean;
  createdAt: string;
}

export interface ChatUnreadSummary {
  activityId: string;
  activityTitle: string;
  chatRoomId: string;
  unreadCount: number;
}
